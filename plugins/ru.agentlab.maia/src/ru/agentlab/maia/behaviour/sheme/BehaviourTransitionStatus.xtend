package ru.agentlab.maia.behaviour.sheme

import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

@Accessors(AccessorType.PUBLIC_GETTER)
class BehaviourTransitionStatus extends BehaviourTransition {

	int status

	new(int status, String name, IBehaviourState fromState, IBehaviourState toState) {
		super(name, fromState, toState)
		this.status = status
	}

}