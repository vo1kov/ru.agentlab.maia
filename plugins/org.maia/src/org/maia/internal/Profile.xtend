package org.maia.internal

import java.util.HashMap
import org.eclipse.xtend2.lib.StringConcatenation
import org.maia.IProfile

class Profile implements IProfile {

	val map = new HashMap<Class<?>, Class<?>>

	override <T> set(Class<T> interf, Class<? extends T> impl) {
		map.put(interf, impl)
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

	override <T> get(Class<T> interf) {
		map.get(interf) as Class<T>
	}

	override getKeys() {
		return map.keySet
	}

	override getValues() {
		map.values
	}

}