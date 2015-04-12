package ru.agentlab.maia.profile

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend2.lib.StringConcatenation

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

class MaiaProfile implements IMaiaProfile {

	@Accessors(AccessorType.PACKAGE_GETTER)
	val map = new HashMap<Class<?>, Class<?>>

	override <T> put(Class<T> interf, Class<? extends T> impl) {
		map.put(interf, impl)
	}

	override <T> get(Class<T> interf) {
		map.get(interf) as Class<T>
	}

	override getKeySet() {
		return map.keySet
	}

	override getValues() {
		map.values
	}

	override remove(Class<?> interf) {
		map.remove(interf)
	}

	override <T> void merge(IMaiaProfile profile) {
		profile.keySet.forEach [
			val key = it as Class<T>
			val value = profile.get(key) as Class<? extends T>
			map.put(key, value)
		]
	}

	override toString() {
		val StringConcatenation sb = ''''''
		map.keySet.sortWith [ a, b |
			a.name.compareTo(b.name)
		].forEach [ p1 |
			sb.newLine
			sb.append("			[")
			sb.append(p1)
			sb.append(", ")
			sb.append(map.get(p1))
			sb.append("]")
		]
		sb.toString
	}

}