package ru.agentlab.maia.behaviour.sheme

import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IBehaviourState

@Accessors(AccessorType.PUBLIC_GETTER)
class BehaviourTransitionStatus extends BehaviourTransition {

	int status

	new(int status, String name, IBehaviourState fromState, IBehaviourState toState) {
		super(name, fromState, toState)
		this.status = status
	}

}