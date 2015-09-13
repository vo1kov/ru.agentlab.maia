package ru.agentlab.maia.memory.context.arraylist.separated

import java.util.ArrayList
import java.util.HashSet
import javax.inject.Provider
import ru.agentlab.maia.memory.context.AbstractContext

class SeparatedArrayListContext extends AbstractContext {

	val stringKeys = new ArrayList<String>

	val stringValues = new ArrayList<Object>

	val classValues = new ArrayList<Object>

	val nullKeys = new ArrayList<Class<?>>

	override synchronized doGetKeySet() {
		return new HashSet<String> => [
			it += stringKeys
			it += classValues.map[return it.class.name]
			it += nullKeys.map[return it.name]
		]
	}

	override synchronized <T> doGetLocal(String name) {
		val index = stringKeys.indexOf(name)
		if (index != -1) {
			val stored = stringValues.get(index)
			if (stored != null) {
				switch (stored) {
					Provider<T>: {
						return stored.get
					}
					default: {
						try {
							return stored as T
						} catch (ClassCastException e) {
							return null
						}
					}
				}
			} else {
				return null
			}
		} else {
			return null
		}
	}

	override synchronized <T> doGetLocal(Class<T> clazz) {
		if (nullKeys.contains(clazz)) {
			return null as T
		} else {
			classValues.findFirst[it.class == clazz] as T
		}
	}

	override synchronized <T> doRemoveLocal(String name) {
		val index = stringKeys.indexOf(name)
		try {
			val stored = stringValues.get(index) as T
			stringValues.remove(index)
			stringKeys.remove(index)
			stringKeys.trimToSize
			stringValues.trimToSize
			return stored as T
		} catch (ClassCastException e) {
			return null
		}
	}

	override synchronized <T> doRemoveLocal(Class<T> clazz) {
		val nullIndex = nullKeys.indexOf(clazz)
		if (nullIndex != -1) {
			nullKeys.remove(nullIndex)
			return null as T
		} else {
			val index = findInClassMap(clazz)
			if (index != -1) {
				val removed = classValues.get(index) as T
				classValues.remove(index)
				return removed
			} else {
				return null
			}
		}
	}

	override synchronized <T> doSetLocal(String name, T value) {
		val index = stringKeys.indexOf(name)
		if (index != -1) {
			stringValues.set(index, value)
		} else {
			stringKeys += name
			stringValues += value
			stringKeys.trimToSize
			stringValues.trimToSize
		}
	}

	def private <T> int findInClassMap(Class<T> clazz) {
		for (i : 0 ..< classValues.size) {
			if (classValues.get(i).class == clazz) {
				return i
			}
		}
		return -1
	}

	override synchronized <T> doSetLocal(Class<T> clazz, T value) {
		if (value != null) {
			if (classValues.empty) {
				classValues += value
				classValues.trimToSize
			} else {
				val int index = clazz.findInClassMap
				if (index != -1) {
					classValues.set(index, value)
				} else {
					classValues += value
					classValues.trimToSize
				}
			}
			nullKeys.remove(clazz)
			nullKeys.trimToSize
		} else {
			if (nullKeys.empty) {
				nullKeys += clazz
				nullKeys.trimToSize
			} else {
				val int index = nullKeys.indexOf(clazz)
				if (index != -1) {
					nullKeys.set(index, clazz)
				} else {
					nullKeys += clazz
					nullKeys.trimToSize
				}
			}
			val ind = findInClassMap(clazz)
			if (ind != -1) {
				classValues.remove(ind)
				classValues.trimToSize
			}
		}
	}

	override synchronized <T> doSetLocal(String name, Provider<T> provider) {
		val index = stringKeys.indexOf(name)
		if (index != -1) {
			stringValues.set(index, provider)
		} else {
			stringKeys += name
			stringValues += provider
			stringKeys.trimToSize
			stringValues.trimToSize
		}
	}

	override synchronized <T> doSetLocal(Class<T> clazz, Provider<T> provider) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override synchronized isContainsLocal(String name) {
		return stringKeys.contains(name)
	}

	override synchronized isContainsLocal(Class<?> clazz) {
		return classValues.findFirst[it.class == clazz] != null
	}

	override synchronized removeAll() {
		stringKeys.clear
		stringValues.clear
		classValues.clear
		nullKeys.clear
		return true
	}

}