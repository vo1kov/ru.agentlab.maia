package ru.agentlab.maia.memory.context.maplisthybrid

import java.util.ArrayList
import java.util.HashMap
import java.util.HashSet
import javax.inject.Provider
import ru.agentlab.maia.memory.context.AbstractContext

class MapListContext extends AbstractContext {

	val stringMap = new HashMap<String, Object>

	val classMap = new ArrayList<Object>

	val nullKeys = new ArrayList<Class<?>>

	override synchronized doGetKeySet() {
		return new HashSet<String> => [
			it += stringMap.keySet
			it += classMap.map[return it.class.name]
			it += nullKeys.map[return it.name]
		]
	}

	override synchronized <T> doGetLocal(String name) {
		val stored = stringMap.get(name)
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
	}

	override synchronized <T> doGetLocal(Class<T> clazz) {
		if (nullKeys.contains(clazz)) {
			return null as T
		} else {
			classMap.findFirst[it.class == clazz] as T
		}
	}

	override synchronized <T> doRemoveLocal(String name) {
		return stringMap.remove(name) as T
	}

	override synchronized <T> doRemoveLocal(Class<T> clazz) {
		val found = classMap.findFirst[it.class == clazz] as T
		val success = classMap.remove(found)
		if (success) {
			return found
		} else {
			return null
		}
	}

	override synchronized <T> doSetLocal(String name, T value) {
		stringMap.put(name, value)
	}

	override synchronized <T> doSetLocal(Class<T> clazz, T value) {
		if (value != null) {
			if (classMap.empty) {
				classMap += value
				classMap.trimToSize
			} else {
				for (i : 0 ..< classMap.size) {
					if (classMap.get(i).class == clazz) {
						classMap.set(i, value)
					} else {
						classMap += value
						classMap.trimToSize
					}
				}
			}
			for (i : 0 ..< nullKeys.size) {
				if (nullKeys.get(i) == clazz) {
					nullKeys.remove(i)
				}
			}
		} else {
			if (nullKeys.empty) {
				nullKeys += clazz
				nullKeys.trimToSize
			} else {
				for (i : 0 ..< nullKeys.size) {
					if (nullKeys.get(i) == clazz) {
						nullKeys.set(i, clazz)
					} else {
						nullKeys += clazz
						nullKeys.trimToSize
					}
				}
			}
			for (i : 0 ..< classMap.size) {
				if (classMap.get(i).class == clazz) {
					classMap.remove(i)
				}
			}
		}
	}

	override protected <T> doSetLocal(String name, Provider<T> provider) {
		stringMap.put(name, provider)
	}

	override protected <T> doSetLocal(Class<T> clazz, Provider<T> provider) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override protected isContainsLocal(String name) {
		return stringMap.containsKey(name)
	}

	override protected isContainsLocal(Class<?> clazz) {
		return classMap.findFirst[it.class == clazz] != null
	}

	override synchronized removeAll() {
		stringMap.clear
		classMap.clear
		nullKeys.clear
		return true
	}

}