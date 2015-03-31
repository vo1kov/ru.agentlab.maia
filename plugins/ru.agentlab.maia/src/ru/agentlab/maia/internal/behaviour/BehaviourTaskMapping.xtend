package ru.agentlab.maia.internal.behaviour

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.sheme.IBehaviourState
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMapping

class BehaviourTaskMapping implements IBehaviourTaskMapping {

	@Accessors
	val map = new HashMap<IBehaviourState, Object>

	override get(IBehaviourState state) {
		map.get(state)
	}
	
	override put(IBehaviourState state, Object task) {
		map.put(state, task)
	}

}