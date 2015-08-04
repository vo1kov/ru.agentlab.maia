package ru.agentlab.maia.context.typing

import java.util.LinkedHashMap

class MaiaProfile implements IMaiaProfile {

	val implementations = new LinkedHashMap<Class<?>, Class<?>>

	val factories = new LinkedHashMap<Class<?>, Class<?>>

	override <T> putImplementation(Class<T> interf, Class<? extends T> impl) {
		implementations.put(interf, impl)
	}

	override <T> putFactory(Class<T> interf, Class<?> factory) {
		factories.put(interf, factory)
	}

	override <T> getImplementation(Class<T> interf) {
		return implementations.get(interf) as Class<T>
	}

	override <T> getFactory(Class<T> interf) {
		return factories.get(interf)
	}

	override removeImplementation(Class<?> interf) {
		implementations.remove(interf)
	}

	override removeFactory(Class<?> interf) {
		factories.remove(interf)
	}

//	override toString() {
//		val StringConcatenation sb = ''''''
//		implementations.keySet.sortWith [ a, b |
//			a.name.compareTo(b.name)
//		].forEach [ p1 |
//			sb.newLine
//			sb.append("			[")
//			sb.append(p1)
//			sb.append(", ")
//			sb.append(implementations.get(p1))
//			sb.append("]")
//		]
//		sb.toString
//	}
	override getFactoryKeySet() {
		return factories.keySet
	}

	override getImplementationKeySet() {
		return implementations.keySet
	}

}