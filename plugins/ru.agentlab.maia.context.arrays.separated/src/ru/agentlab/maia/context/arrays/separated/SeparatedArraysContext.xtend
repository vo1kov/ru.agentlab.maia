package ru.agentlab.maia.context.arrays.separated

import java.util.Arrays
import java.util.HashSet
import ru.agentlab.maia.context.Context
import ru.agentlab.maia.context.exception.MaiaContextKeyNotFound

/**
 * TODO: migrate from ArrayLists to Object[]. 
 * After trimToSize capacity will equal to size.
 * After registering new service capacity will increase by x1.5
 * to avoid that size fluctuations it is need to change to Object[]
 *  
 */
class SeparatedArraysContext extends Context {

	val static UNKNOWN = -1

	var protected String[] stringKeys = newArrayOfSize(0)

	var protected Object[] stringValues = newArrayOfSize(0)

	/**
	 * <p>
	 * Array for storing string-keys for null-value-services and null-value-providers.
	 * </p><p>
	 * Array is populating when register service by <code>putService(String, null)</code>
	 * or <code>putProvider(String, null)</code>.
	 * </p>
	 */
	var protected String[] stringNulls = newArrayOfSize(0)

	var protected Class<?>[] classKeys = newArrayOfSize(0)

	var protected Object[] classValues = newArrayOfSize(0)

	/**
	 * <p>
	 * Array for storing class-keys for null-value-services and null-value-providers.
	 * </p><p>
	 * Array is populating when register service by <code>putService(Class, null)</code>
	 * or <code>putProvider(Class, null)</code>.
	 * </p>
	 */
	var protected Class<?>[] classNulls = newArrayOfSize(0)

	override protected synchronized getInternal(String key) {
		// try to find key in null string storage
		if (stringNulls.indexOf(key) != UNKNOWN) {
			return null
		}
		// try to find key in null class storage
		if (classNulls.indexOfClassName(key) != UNKNOWN) {
			return null
		}
		// try to find key in string storage
		val stringKeyIndex = stringKeys.indexOf(key)
		if (stringKeyIndex != UNKNOWN) {
			return stringValues.get(stringKeyIndex)
		}
		// try to find key in class storage
		val classKeyIndex = findInClassMap(key)
		if (classKeyIndex != UNKNOWN) {
			return classValues.get(classKeyIndex)
		}
		throw new MaiaContextKeyNotFound(
			'''Value for key [«key»] did not found in context [«this.toString»] and all their parents'''
		)
	}

	override protected synchronized getInternal(Class<?> key) {
		// try to find key in null class storage
		if (classNulls.indexOf(key) != UNKNOWN) {
			return null
		}
		// try to find key in null string storage
		if (stringNulls.indexOf(key.name) != UNKNOWN) {
			return null
		}
		// try to find key in class storage
		val classKeyIndex = classKeys.indexOf(key)
		if (classKeyIndex != UNKNOWN) {
			return classValues.get(classKeyIndex)
		}
		// try to find key in string storage
		val stringKeyIndex = stringKeys.indexOf(key.name)
		if (stringKeyIndex != UNKNOWN) {
			return stringValues.get(stringKeyIndex)
		}
		throw new MaiaContextKeyNotFound(
			'''Value for key [«key»] did not found in context [«this.toString»] and all their parents'''
		)
	}

	override protected synchronized putInternal(String name, Object value) {
		val index = stringKeys.indexOf(name)
		if (index != UNKNOWN) {
			val old = stringValues.get(index)
			stringValues.set(index, value)
			return old
		} else {
			stringKeys = stringKeys.add(name)
			stringValues = stringValues.add(value)
			return null
		}
	}

	override protected synchronized putInternal(Class<?> clazz, Object value) {
		if (value != null) {
			if (classValues.length == 0) {
				classValues = classValues.add(value)
			} else {
				val int index = clazz.findInClassMap
				if (index != UNKNOWN) {
					classValues.set(index, value)
				} else {
					classValues = classValues.add(value)
				}
			}
			val ind = classNulls.indexOf(clazz)
			if (ind != UNKNOWN) {
				classNulls = classNulls.remove(ind)
			}
		} else {
			if (classNulls.length == 0) {
				classNulls = classNulls.add(clazz)
			} else {
				val int index = classNulls.indexOf(clazz)
				if (index != UNKNOWN) {
					classNulls.set(index, clazz)
				} else {
					classNulls = classNulls.add(clazz)
				}
			}
			val ind = findInClassMap(clazz)
			if (ind != UNKNOWN) {
				classValues = classValues.remove(ind)
			}
		}
	}

	override protected synchronized removeInternal(String name) {
		val nullIndex = stringNulls.indexOf(name)
		if (nullIndex != UNKNOWN) {
			stringNulls = stringNulls.remove(nullIndex)
			return null
		} else {
			val index = stringKeys.indexOf(name)
			val stored = stringValues.get(index)
			stringValues = stringValues.remove(index)
			stringKeys = stringKeys.remove(index)
			return stored
		}
	}

	override protected synchronized removeInternal(Class<?> clazz) {
		val nullIndex = classNulls.indexOf(clazz)
		if (nullIndex != UNKNOWN) {
			classNulls = classNulls.remove(nullIndex)
			return null
		} else {
			val index = findInClassMap(clazz)
			if (index != UNKNOWN) {
				val removed = classValues.get(index)
				classValues = classValues.remove(index)
				return removed
			} else {
				return null
			}
		}
	}

	def protected <T> int indexOf(T[] array, T element) {
		for (i : 0 ..< array.length) {
			if (element.equals(array.get(i))) {
				return i
			}
		}
		return UNKNOWN
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

	def protected <T> int findInClassMap(Class<T> clazz) {
		for (i : 0 ..< classValues.length) {
			if (classValues.get(i).class == clazz) {
				return i
			}
		}
		return UNKNOWN
	}

	def protected <T> int findInClassMap(String name) {
		for (i : 0 ..< classKeys.length) {
			if (classKeys.get(i).class.name.equals(name)) {
				return i
			}
		}
		return UNKNOWN
	}

	def protected <T> int indexOfClassName(T[] array, String name) {
		for (i : 0 ..< array.length) {
			if (array.get(i).class.name.equals(name)) {
				return i
			}
		}
		return UNKNOWN
	}

	override synchronized getKeySet() {
		return new HashSet<String> => [
			it += stringKeys
			it += stringNulls
			it += classValues.map[return it.class.name]
			it += classNulls.map[return it.name]
		]
	}

	override synchronized clear() {
		stringKeys = newArrayOfSize(0)
		stringValues = newArrayOfSize(0)
		stringNulls = newArrayOfSize(0)
		classValues = newArrayOfSize(0)
		classNulls = newArrayOfSize(0)
		return true
	}

}
