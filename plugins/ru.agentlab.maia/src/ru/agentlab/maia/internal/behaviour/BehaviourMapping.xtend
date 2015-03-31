package ru.agentlab.maia.internal.behaviour

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IBehaviourState
import ru.agentlab.maia.behaviour.IBehaviourMapping

class BehaviourMapping implements IBehaviourMapping {
	
	@Accessors
	val map = new HashMap<IBehaviourState, Object>
	
	override get(IBehaviourState state) {
		map.get(state)
	}
	
}