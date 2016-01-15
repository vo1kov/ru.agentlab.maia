package ru.agentlab.maia.container.hashmap

import java.util.HashMap
import java.util.Map
import ru.agentlab.maia.context.exception.MaiaContextKeyNotFound
import ru.agentlab.maia.container.Container
import ru.agentlab.maia.IContainer

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
class HashMapContext extends Container implements IContainer {

	val Map<String, Object> map = new HashMap<String, Object>

	override protected synchronized getInternal(String key) {
		if (map.containsKey(key)) {
			return map.get(key)
		} else {
			throw new MaiaContextKeyNotFound(
				'''Value for key [«key»] did not found in context [«this.toString»] and all their parents'''
			)
		}
	}

	override protected synchronized getInternal(Class<?> key) {
		if (map.containsKey(key.name)) {
			return map.get(key.name)
		} else {
			throw new MaiaContextKeyNotFound(
				'''Value for key [«key»] did not found in context [«this.toString»] and all their parents'''
			)
		}
	}

	override protected synchronized putInternal(String name, Object value) {
		return map.put(name, value)
	}

	override protected synchronized putInternal(Class<?> clazz, Object value) {
		return map.put(clazz.name, value)
	}

	override protected synchronized removeInternal(String name) {
		return map.remove(name)
	}

	override protected synchronized removeInternal(Class<?> clazz) {
		return map.remove(clazz.name)
	}

	override synchronized getKeySet() {
		return map.keySet
	}

	override synchronized clear() {
		map.clear
		return true
	}

}
