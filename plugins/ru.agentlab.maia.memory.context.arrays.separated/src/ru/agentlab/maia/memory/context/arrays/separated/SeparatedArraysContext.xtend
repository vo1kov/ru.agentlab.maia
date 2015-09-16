package ru.agentlab.maia.memory.context.arrays.separated

import java.util.Arrays
import java.util.HashSet
import ru.agentlab.maia.memory.context.AbstractContext

/**
 * TODO: migrate from ArrayLists to Object[]. 
 * After trimToSize capacity will equal to size.
 * After registering new service capacity will increase by x1.5
 * to avoid that size fluctuations it is need to change to Object[]
 *  
 */
class SeparatedArraysContext extends AbstractContext {

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

	override protected synchronized getInternal(String name) {
		// try to find key in null string storage
		if (stringNulls.indexOf(name) != -1) {
			return null
		}
		// try to find key in null class storage
		if (classNulls.indexOfClassName(name) != -1) {
			return null
		}
		// try to find key in string storage
		val stringKeyIndex = stringKeys.indexOf(name)
		if (stringKeyIndex != -1) {
			return stringValues.get(stringKeyIndex)
		}
		// try to find key in class storage
		val classKeyIndex = findInClassMap(name)
		if (classKeyIndex != -1) {
			return classValues.get(classKeyIndex)
		}
		return null
	}

	override protected synchronized getInternal(Class<?> clazz) {
		// try to find key in null class storage
		if (classNulls.indexOf(clazz) != -1) {
			return null
		}
		// try to find key in null string storage
		if (stringNulls.indexOf(clazz.name) != -1) {
			return null
		}
		// try to find key in class storage
		val classKeyIndex = classKeys.indexOf(clazz)
		if (classKeyIndex != -1) {
			return classValues.get(classKeyIndex)
		}
		// try to find key in string storage
		val stringKeyIndex = stringKeys.indexOf(clazz.name)
		if (stringKeyIndex != -1) {
			return stringValues.get(stringKeyIndex)
		}
		return null
	}

	override protected synchronized putInternal(String name, Object value) {
		val index = stringKeys.indexOf(name)
		if (index != -1) {
			stringValues.set(index, value)
		} else {
			stringKeys = stringKeys.add(name)
			stringValues = stringValues.add(value)
		}
	}

	override protected synchronized putInternal(Class<?> clazz, Object value) {
		if (value != null) {
			if (classValues.length == 0) {
				classValues = classValues.add(value)
			} else {
				val int index = clazz.findInClassMap
				if (index != -1) {
					classValues.set(index, value)
				} else {
					classValues = classValues.add(value)
				}
			}
			val ind = classNulls.indexOf(clazz)
			if (ind != -1) {
				classNulls = classNulls.remove(ind)
			}
		} else {
			if (classNulls.length == 0) {
				classNulls = classNulls.add(clazz)
			} else {
				val int index = classNulls.indexOf(clazz)
				if (index != -1) {
					classNulls.set(index, clazz)
				} else {
					classNulls = classNulls.add(clazz)
				}
			}
			val ind = findInClassMap(clazz)
			if (ind != -1) {
				classValues = classValues.remove(ind)
			}
		}
	}

	override protected synchronized removeInternal(String name) {
		val nullIndex = stringNulls.indexOf(name)
		if (nullIndex != -1) {
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
		if (nullIndex != -1) {
			classNulls = classNulls.remove(nullIndex)
			return null
		} else {
			val index = findInClassMap(clazz)
			if (index != -1) {
				val removed = classValues.get(index)
				classValues = classValues.remove(index)
				return removed
			} else {
				return null
			}
		}
	}

	override protected synchronized containsInternal(String name) {
		return stringKeys.contains(name)
	}

	override protected synchronized containsInternal(Class<?> clazz) {
		return classValues.findFirst[it.class == clazz] != null
	}

	override protected synchronized clearInternal() {
		stringKeys = newArrayOfSize(0)
		stringValues = newArrayOfSize(0)
		stringNulls = newArrayOfSize(0)
		classValues = newArrayOfSize(0)
		classNulls = newArrayOfSize(0)
		return true
	}

	override protected synchronized getKeySetInternal() {
		return new HashSet<String> => [
			it += stringKeys
			it += stringNulls
			it += classValues.map[return it.class.name]
			it += classNulls.map[return it.name]
		]
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

	def protected <T> int findInClassMap(Class<T> clazz) {
		for (i : 0 ..< classValues.length) {
			if (classValues.get(i).class == clazz) {
				return i
			}
		}
		return -1
	}

	def protected <T> int findInClassMap(String name) {
		for (i : 0 ..< classKeys.length) {
			if (classKeys.get(i).class.name.equals(name)) {
				return i
			}
		}
		return -1
	}

	def protected <T> int indexOfClassName(T[] array, String name) {
		for (i : 0 ..< array.length) {
			if (array.get(i).class.name.equals(name)) {
				return i
			}
		}
		return -1
	}

}