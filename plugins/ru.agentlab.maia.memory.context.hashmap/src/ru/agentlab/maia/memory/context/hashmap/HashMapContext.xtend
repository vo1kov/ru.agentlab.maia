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
 * <li>isContainsLocal() complexity: <b>O(1)</b>;</li>
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

	override protected getInternal(String name) {
		return map.get(name)
	}

	override protected getInternal(Class<?> clazz) {
		return map.get(clazz.name)
	}

	override protected putInternal(String name, Object value) {
		map.put(name, value)
	}

	override protected putInternal(Class<?> clazz, Object value) {
		map.put(clazz.name, value)
	}

	override protected removeInternal(String name) {
		return map.remove(name)
	}

	override protected removeInternal(Class<?> clazz) {
		return map.remove(clazz.name)
	}

	override protected containsInternal(String name) {
		return map.containsKey(name)
	}

	override protected containsInternal(Class<?> clazz) {
		return map.containsKey(clazz.name)
	}

	override protected getKeySetInternal() {
		return map.keySet
	}

	override protected clearInternal() {
		map.clear
		return true
	}

}