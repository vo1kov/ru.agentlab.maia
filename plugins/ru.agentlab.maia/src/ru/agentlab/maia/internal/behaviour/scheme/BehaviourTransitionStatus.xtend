package ru.agentlab.maia.internal.behaviour.scheme

import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.sheme.IBehaviourState
import ru.agentlab.maia.TaskInput

@Accessors(AccessorType.PUBLIC_GETTER)
class BehaviourTransitionStatus extends BehaviourTransition {
	
	@TaskInput
	int status

	new(int status, String name, IBehaviourState fromState, IBehaviourState toState) {
		super(name, fromState, toState)
		this.status = status
	}

}