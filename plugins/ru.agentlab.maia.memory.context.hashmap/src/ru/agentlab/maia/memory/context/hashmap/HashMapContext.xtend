package ru.agentlab.maia.memory.context.hashmap

import java.util.Collections
import java.util.HashMap
import java.util.Map
import javax.inject.Provider
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

	override protected <T> doGetServiceLocal(String name) {
		val value = map.get(name)
		if (value instanceof Provider<?>) {
			try {
				return value.get as T
			} catch (ClassCastException e) {
				return null
			}
		} else {
			try {
				return value as T
			} catch (ClassCastException e) {
				return null
			}
		}
	}

	override protected <T> doGetServiceLocal(Class<T> clazz) {
		val value = map.get(clazz.name)
		if (value instanceof Provider<?>) {
			try {
				return value.get as T
			} catch (ClassCastException e) {
				return null
			}
		} else {
			try {
				return value as T
			} catch (ClassCastException e) {
				return null
			}
		}
	}

	override protected doGetProviderLocal(String name) {
		val value = map.get(name)
		if (value instanceof Provider<?>) {
			return value
		} else {
			return null
		}
	}

	override protected <T> doGetProviderLocal(Class<T> clazz) {
		val value = map.get(clazz.name)
		if (value instanceof Provider<?>) {
			try {
				return value as Provider<T>
			} catch (ClassCastException e) {
				return null
			}
		} else {
			return null
		}
	}

	override protected doPutServiceLocal(String name, Object value) {
		map.put(name, value)
	}

	override protected <T> doPutServiceLocal(Class<T> clazz, T value) {
		map.put(clazz.name, value)
	}

	override protected doPutProviderLocal(String name, Provider<?> provider) {
		map.put(name, provider)
	}

	override protected <T> doPutProviderLocal(Class<T> clazz, Provider<T> provider) {
		map.put(clazz.name, provider)
	}

	override protected doRemoveLocal(String name) {
		return map.remove(name)
	}

	override protected doRemoveLocal(Class<?> clazz) {
		return map.remove(clazz.name)
	}

	override protected isContainsLocal(String name) {
		return map.containsKey(name)
	}

	override protected isContainsLocal(Class<?> clazz) {
		return map.containsKey(clazz.name)
	}

	override protected doGetKeySet() {
		return map.keySet
	}
	
	override protected doClearLocal() {
		map.clear
		return true
	}

}