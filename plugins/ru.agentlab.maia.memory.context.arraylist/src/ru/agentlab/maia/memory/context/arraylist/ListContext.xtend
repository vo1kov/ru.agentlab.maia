package ru.agentlab.maia.memory.context.arraylist

import java.util.ArrayList
import java.util.HashSet
import java.util.LinkedList
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.AbstractContext

/**
 * <p>{@link IMaiaContext} realization based on {@link LinkedList} for storing keys and values.</p>
 * 
 * <ul>Main parameters:
 * <li>getLocal() complexity: <b>O(SIZE + 1)</b>;</li>
 * <li>setLocal() complexity: <b>O(SIZE + 1)</b>;</li>
 * <li>memory usage: <b>O(8 * SIZE) bytes</b>;</li>
 * </ul>
 * <p>where SIZE - service count.</p>
 * <p>Empty context will allocate approximately <b>64 bytes</b>.</p>
 * 
 * <p><b>Important!</b> This realization does not retrieve services by it's subclass. Context
 * retrieve context only by identifier that was used while registration service on context.</p>
 * 
 * @see <a href='http://java-performance.info/memory-consumption-of-java-data-types-1/'>ArrayList memory consumption</a>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class ListContext extends AbstractContext {

	val ArrayList<String> keys = new ArrayList

	val ArrayList<Object> values = new ArrayList

	override synchronized doGetLocal(String name) {
		val index = keys.indexOf(name)
		if (index != -1) {
			return values.get(index)
		} else {
			return null
		}
	}

	override synchronized <T> doGetLocal(Class<T> clazz) {
		val index = keys.indexOf(clazz.name)
		try {
			if (index != -1) {
				return values.get(index) as T
			} else {
				return null
			}
		} catch (ClassCastException e) {
			return null
		}
	}

	override synchronized doSetLocal(String name, Object value) {
		val index = keys.indexOf(name)
		if (index != -1) {
			values.set(index, value)
		} else {
			keys.add(name)
			values.add(value)
			keys.trimToSize
			values.trimToSize
		}
	}

	override synchronized <T> doSetLocal(Class<T> clazz, T value) {
		val index = keys.indexOf(clazz.name)
		if (index != -1) {
			values.set(index, value)
		} else {
			keys.add(clazz.name)
			values.add(value)
			keys.trimToSize
			values.trimToSize
		}
	}

	override synchronized doRemoveLocal(String name) {
		val index = keys.indexOf(name)
		if (index != -1) {
			keys.remove(index)
			return values.remove(index)
		} else {
			return null
		}
	}

	override synchronized <T> doRemoveLocal(Class<T> clazz) {
		val index = keys.indexOf(clazz.name)
		if (index != -1) {
			keys.remove(index)
			return values.remove(index) as T
		} else {
			return null
		}
	}

	override synchronized doGetKeySet() {
		return new HashSet<String>(keys)
	}

}