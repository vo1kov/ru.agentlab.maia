package ru.agentlab.maia.context.typing

import java.util.LinkedHashMap

class MaiaProfile implements IMaiaProfile {

	val implementations = new LinkedHashMap<Class<?>, Class<?>>

	override <T> putImplementation(Class<T> interf, Class<? extends T> impl) {
		implementations.put(interf, impl)
	}

	override <T> getImplementation(Class<T> interf) {
		return implementations.get(interf) as Class<T>
	}

	override removeImplementation(Class<?> interf) {
		implementations.remove(interf)
	}

	override getImplementationKeySet() {
		return implementations.keySet
	}

}