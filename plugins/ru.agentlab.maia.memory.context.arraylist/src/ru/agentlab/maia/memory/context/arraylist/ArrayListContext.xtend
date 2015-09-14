package ru.agentlab.maia.memory.context.arraylist

import java.util.ArrayList
import java.util.HashSet
import java.util.LinkedList
import javax.inject.Provider
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.AbstractContext

/**
 * <p>{@link IMaiaContext} realization based on {@link LinkedList} for storing keys and values.</p>
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
class ArrayListContext extends AbstractContext {
	
	val static UNKNOWN = -1

	val protected ArrayList<String> keys = new ArrayList

	val protected ArrayList<Object> values = new ArrayList

	override protected synchronized doGetServiceLocal(String name) {
		val index = keys.indexOf(name)
		if (index != UNKNOWN) {
			return values.get(index)
		} else {
			return null
		}
	}

	override protected synchronized <T> doGetServiceLocal(Class<T> clazz) {
		val index = keys.indexOf(clazz.name)
		try {
			if (index != UNKNOWN) {
				return values.get(index) as T
			} else {
				return null
			}
		} catch (ClassCastException e) {
			return null
		}
	}
	
	override protected synchronized doGetProviderLocal(String string) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override protected synchronized <T> doGetProviderLocal(Class<T> clazz) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override protected synchronized doPutServiceLocal(String name, Object value) {
		val index = keys.indexOf(name)
		if (index != UNKNOWN) {
			values.set(index, value)
		} else {
			putInternal(name, value)
		}
	}

	override protected synchronized <T> doPutServiceLocal(Class<T> clazz, T value) {
		val index = keys.indexOf(clazz.name)
		if (index != UNKNOWN) {
			values.set(index, value)
		} else {
			putInternal(clazz.name, value)
		}
	}

	override protected synchronized doPutProviderLocal(String name, Provider<?> provider) {
		val index = keys.indexOf(name)
		if (index != UNKNOWN) {
			values.set(index, provider)
		} else {
			putInternal(name, provider)
		}
	}

	override protected synchronized <T> doPutProviderLocal(Class<T> clazz, Provider<T> provider) {
		val index = keys.indexOf(clazz.name)
		if (index != UNKNOWN) {
			values.set(index, provider)
		} else {
			putInternal(clazz.name, provider)
		}
	}

	override protected synchronized doRemoveLocal(String name) {
		val index = keys.indexOf(name)
		if (index != UNKNOWN) {
			keys.remove(index)
			return values.remove(index)
		} else {
			return null
		}
	}

	override protected synchronized doRemoveLocal(Class<?> clazz) {
		val index = keys.indexOf(clazz.name)
		if (index != UNKNOWN) {
			keys.remove(index)
			return values.remove(index)
		} else {
			return null
		}
	}

	override protected synchronized isContainsLocal(String name) {
		return keys.indexOf(name) != UNKNOWN
	}

	override protected synchronized isContainsLocal(Class<?> clazz) {
		return keys.indexOf(clazz.name) != UNKNOWN
	}
	
	override protected synchronized doClearLocal() {
		keys.clear
		values.clear
		return true
	}

	override protected synchronized doGetKeySet() {
		return new HashSet<String>(keys)
	}

	def private putInternal(String key, Object value) {
		keys.add(key)
		values.add(value)
		keys.trimToSize
		values.trimToSize
	}

}