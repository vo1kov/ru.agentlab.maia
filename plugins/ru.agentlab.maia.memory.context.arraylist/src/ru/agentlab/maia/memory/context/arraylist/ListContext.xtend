package ru.agentlab.maia.memory.context.arraylist

import java.util.ArrayList
import java.util.LinkedList
import java.util.List
import ru.agentlab.maia.memory.context.AbstractContext

/**
 * <p>{@link IMaiaContext} realization based on {@link LinkedList} for storing keys and
 * {@link ArrayList} for storing values.</p>
 * 
 * <ul>Main parameters:
 * <li>getLocal() complexity: <b>O(SIZE + 1)</b>;</li>
 * <li>setLocal() complexity: <b>O(SIZE + 1)</b>;</li>
 * <li>memory usage: <b>O(32 * SIZE) bytes</b>;</li>
 * </ul>
 * 
 * <p>where SIZE - service count.</p>
 * <p>Empty context will allocate approximately <b>64 bytes</b>.</p>
 * 
 * <p><b>Important!</b> This realization does not retrieve services by it's subclass. Context
 * retrieve context only by identifier that was used while registration service on context.</p>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class ListContext extends AbstractContext {

	val List<String> keys = new ArrayList

	val List<Object> values = new ArrayList

	override synchronized doGetLocal(String name) {
		val index = keys.indexOf(name)
		return values.get(index)
	}

	override synchronized <T> doGetLocal(Class<T> clazz) {
		val index = keys.indexOf(clazz.name)
		val value = values.get(index)
		try {
			return value as T
		} catch (ClassCastException e) {
			return null
		}
	}

	override synchronized doSetLocal(String name, Object value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override synchronized <T> doSetLocal(Class<T> clazz, T value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
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

	override doGetKeySet() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}