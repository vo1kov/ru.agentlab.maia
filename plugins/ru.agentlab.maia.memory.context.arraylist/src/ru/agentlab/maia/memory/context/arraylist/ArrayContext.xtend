package ru.agentlab.maia.memory.context.arraylist

import java.util.Arrays
import java.util.HashSet
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.AbstractContext

/**
 * <p>{@link IMaiaContext} realization based on 2 arrays for storing keys and values.</p>
 * 
 * <p>Main parameters:</p>
 * <ul>
 * <li><code>getLocal()</code> complexity: 			<b>O(SIZE)</b>;</li>
 * <li><code>setLocal()</code> complexity: 			<b>O(SIZE)</b>;</li>
 * <li><code>isContainsLocal()</code> complexity:	<b>O(SIZE)</b>;</li>
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
class ArrayContext extends AbstractContext {

	val static UNKNOWN = -1

	var protected String[] keys = newArrayOfSize(0)

	var protected Object[] values = newArrayOfSize(0)

	override protected synchronized getInternal(String name) {
		return getValue(name)
	}

	override protected synchronized getInternal(Class<?> clazz) {
		return getValue(clazz.name)
	}

	override protected synchronized putInternal(String name, Object value) {
		setValue(name, value)
	}

	override protected synchronized putInternal(Class<?> clazz, Object value) {
		setValue(clazz.name, value)
	}

	override protected synchronized removeInternal(String name) {
		return removeValue(name)
	}

	override protected synchronized removeInternal(Class<?> clazz) {
		return removeValue(clazz.name)
	}

	override protected synchronized containsInternal(String name) {
		return keys.indexOf(name) != UNKNOWN
	}

	override protected synchronized containsInternal(Class<?> clazz) {
		return keys.indexOf(clazz.name) != UNKNOWN
	}

	override protected synchronized clearInternal() {
		keys.clear
		values.clear
		return true
	}

	override protected synchronized getKeySetInternal() {
		return new HashSet<String>(keys)
	}

	def protected <T> int indexOf(T[] array, T element) {
		for (i : 0 ..< array.length) {
			if (element.equals(array.get(i))) {
				return i
			}
		}
		return -1
	}

	def protected <T> T[] remove(T[] array, int index) {
		val int numMoved = array.length - index - 1
		if (numMoved > 0) {
			System.arraycopy(array, index + 1, array, index, numMoved)
		}
		val result = Arrays.copyOf(array, array.length - 1)
		return result
	}

	def protected <T> T[] add(T[] array, T element) {
		val result = Arrays.copyOf(array, array.length + 1)
		result.set(result.length - 1, element)
		return result
	}

	def private Object getValue(String key) {
		val index = keys.indexOf(key)
		if (index != UNKNOWN) {
			return values.get(index)
		} else {
			return null
		}
	}

	def private Object setValue(String key, Object value) {
		val index = keys.indexOf(key)
		if (index != UNKNOWN) {
			values.set(index, value)
		} else {
			keys = keys.add(key)
			values = values.add(value)
		}
	}

	def private Object removeValue(String key) {
		val index = keys.indexOf(key)
		if (index != UNKNOWN) {
			keys = keys.remove(index)
			return values = values.remove(index)
		} else {
			return null
		}
	}

}