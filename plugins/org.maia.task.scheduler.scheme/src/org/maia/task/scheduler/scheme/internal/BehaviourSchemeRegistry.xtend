package org.maia.task.scheduler.scheme.internal

import java.util.ArrayList
import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend2.lib.StringConcatenation
import org.maia.task.scheduler.scheme.IBehaviourScheme
import org.maia.task.scheduler.scheme.IBehaviourSchemeRegistry

@Accessors
class BehaviourSchemeRegistry implements IBehaviourSchemeRegistry {

	IBehaviourScheme defaultScheme

	Collection<IBehaviourScheme> schemes = new ArrayList<IBehaviourScheme>

	override toString() {
		val StringConcatenation sb = ''''''
		sb.newLine
		sb.append('''			default: [«defaultScheme»]''')
		schemes.forEach [ p1 |
			sb.newLine
			sb.append("			[")
			sb.append(p1)
			sb.append("]")
		]
		sb.toString

	}

}