package ru.agentlab.maia.memory.context.hashmap

import java.util.Collections
import java.util.HashMap
import java.util.Map
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.AbstractContext

/**
 * <p>{@link IMaiaContext} realization based on {@link HashMap} for storing keys and values.</p>
 * 
 * <ul>Main parameters:
 * <li>getLocal() complexity: <b>O(1)</b>;</li>
 * <li>setLocal() complexity: <b>O(1)</b>;</li>
 * <li>memory usage: <b>O(32 * SIZE + 4 * CAPACITY) bytes</b>;</li>
 * </ul>
 * 
 * <p>where SIZE - service count, CAPACITY - capacity of map.</p>
 * <p>Empty context will allocate approximately <b>64 bytes</b>.</p>
 * 
 * <p><b>Important!</b> This realization does not retrieve services by it's subclass. Context
 * retrieve context only by identifier that was used while registration service on context.</p>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class HashMapContext extends AbstractContext {

	val Map<String, Object> map = Collections.synchronizedMap(new HashMap<String, Object>);

	override doGetLocal(String name) {
		return map.get(name)
	}

	override <T> doGetLocal(Class<T> clazz) {
		val value = map.get(clazz.name)
		try {
			return value as T
		} catch (ClassCastException e) {
			return null
		}
	}

	override doSetLocal(String name, Object value) {
		map.put(name, value)
	}

	override <T> doSetLocal(Class<T> clazz, T value) {
		map.put(clazz.name, value)
	}

	override doRemoveLocal(String name) {
		map.remove(name)
	}

	override <T> doRemoveLocal(Class<T> clazz) {
		map.remove(clazz.name) as T
	}

	override doGetKeySet() {
		map.keySet
	}

}