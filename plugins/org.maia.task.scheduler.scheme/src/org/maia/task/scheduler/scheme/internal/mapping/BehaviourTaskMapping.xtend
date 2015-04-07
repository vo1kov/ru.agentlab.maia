package org.maia.task.scheduler.scheme.internal.mapping

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend2.lib.StringConcatenation
import org.maia.task.scheduler.scheme.IBehaviourState
import org.maia.task.scheduler.scheme.mapping.IBehaviourTaskMapping

class BehaviourTaskMapping implements IBehaviourTaskMapping {

	@Accessors
	val map = new HashMap<IBehaviourState, Object>

	override get(IBehaviourState state) {
		map.get(state)
	}

	override put(IBehaviourState state, Object task) {
		map.put(state, task)
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