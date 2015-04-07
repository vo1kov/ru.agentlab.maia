package org.maia.internal

import java.util.concurrent.ConcurrentHashMap
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend2.lib.StringConcatenation
import org.maia.IContextFactory

class LocalAgentRegistry {

	var agents = new ConcurrentHashMap<String, IEclipseContext>

	def void put(String aid, IEclipseContext a) {
		agents.put(aid, a)
	}

	def IEclipseContext get(String aid) {
		agents.get(aid)
	}

	def void remove(String key) {
		agents.remove(key)
	}

	def String[] keys() {
		agents.keySet
	}

	def IEclipseContext[] values() {
		agents.values
	}

	def boolean contains(String key) {
		agents.containsKey(key)
	}

	override toString() {
		val StringConcatenation sb = ''''''
		agents.forEach [ id, ctx |
			sb.newLine
			sb.append("			[")
			sb.append(ctx.get(IContextFactory.KEY_NAME))
			sb.append("]")
		]
		sb.toString
	}

}
