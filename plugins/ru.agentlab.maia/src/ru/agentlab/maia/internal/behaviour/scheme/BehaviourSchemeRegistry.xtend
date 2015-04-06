package ru.agentlab.maia.internal.behaviour.scheme

import java.util.ArrayList
import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend2.lib.StringConcatenation
import ru.agentlab.maia.behaviour.sheme.IBehaviourScheme
import ru.agentlab.maia.behaviour.sheme.IBehaviourSchemeRegistry

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