package ru.agentlab.maia.memory.context.arraylist.separated

import java.util.Arrays
import java.util.HashSet
import javax.inject.Provider
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

	var protected String[] nullStringKeys = newArrayOfSize(0)

	var protected Object[] classValues = newArrayOfSize(0)

	var protected Class<?>[] nullKeys = newArrayOfSize(0)

	override protected synchronized doGetServiceLocal(String name) {
		val nullIndex = nullStringKeys.indexOf(name)
		if (nullIndex != -1) {
			return null
		} else {
			val index = stringKeys.indexOf(name)
			if (index != -1) {
				val stored = stringValues.get(index)
				if (stored != null) {
					switch (stored) {
						Provider<?>: {
							return stored.get
						}
						default: {
							return stored
						}
					}
				} else {
					return null
				}
			} else {
				return null
			}
		}
	}

	override protected synchronized <T> doGetServiceLocal(Class<T> clazz) {
		val nullIndex = nullKeys.indexOf(clazz)
		if (nullIndex != -1) {
			return null
		} else {
			for (c : classValues) {
				if (c.class == clazz) {
					return c as T
				}
			}
		}
	}
	
	override protected synchronized doGetProviderLocal(String string) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override protected synchronized <T> doGetProviderLocal(Class<T> clazz) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override protected synchronized doPutServiceLocal(String name, Object value) {
		val index = stringKeys.indexOf(name)
		if (index != -1) {
			stringValues.set(index, value)
		} else {
			stringKeys = stringKeys.add(name)
			stringValues = stringValues.add(value)
		}
	}

	override protected synchronized <T> doPutServiceLocal(Class<T> clazz, T value) {
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
			val ind = nullKeys.indexOf(clazz)
			if (ind != -1) {
				nullKeys = nullKeys.remove(ind)
			}
		} else {
			if (nullKeys.length == 0) {
				nullKeys = nullKeys.add(clazz)
			} else {
				val int index = nullKeys.indexOf(clazz)
				if (index != -1) {
					nullKeys.set(index, clazz)
				} else {
					nullKeys = nullKeys.add(clazz)
				}
			}
			val ind = findInClassMap(clazz)
			if (ind != -1) {
				classValues = classValues.remove(ind)
			}
		}
	}

	override protected synchronized doPutProviderLocal(String name, Provider<?> provider) {
		val index = stringKeys.indexOf(name)
		if (index != -1) {
			stringValues.set(index, provider)
		} else {
			stringKeys = stringKeys.add(name)
			stringValues = stringValues.add(provider)
		}
	}

	override protected synchronized <T> doPutProviderLocal(Class<T> clazz, Provider<T> provider) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override protected synchronized doRemoveLocal(String name) {
		val nullIndex = nullStringKeys.indexOf(name)
		if (nullIndex != -1) {
			nullStringKeys = nullStringKeys.remove(nullIndex)
			return null
		} else {
			val index = stringKeys.indexOf(name)
			val stored = stringValues.get(index)
			stringValues = stringValues.remove(index)
			stringKeys = stringKeys.remove(index)
			return stored
		}
	}

	override protected synchronized doRemoveLocal(Class<?> clazz) {
		val nullIndex = nullKeys.indexOf(clazz)
		if (nullIndex != -1) {
			nullKeys = nullKeys.remove(nullIndex)
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

	override protected synchronized isContainsLocal(String name) {
		return stringKeys.contains(name)
	}

	override protected synchronized isContainsLocal(Class<?> clazz) {
		return classValues.findFirst[it.class == clazz] != null
	}

	override protected synchronized doClearLocal() {
		stringKeys = newArrayOfSize(0)
		stringValues = newArrayOfSize(0)
		nullStringKeys = newArrayOfSize(0)
		classValues = newArrayOfSize(0)
		nullKeys = newArrayOfSize(0)
		return true
	}

	override protected synchronized doGetKeySet() {
		return new HashSet<String> => [
			it += stringKeys
			it += nullStringKeys
			it += classValues.map[return it.class.name]
			it += nullKeys.map[return it.name]
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
		for (i : 0 ..< classValues.size) {
			if (classValues.get(i).class == clazz) {
				return i
			}
		}
		return -1
	}

}