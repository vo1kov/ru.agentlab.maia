package ru.agentlab.maia.internal.behaviour.scheme

import ru.agentlab.maia.behaviour.sheme.IBehaviourState

class BehaviourTransitionDefault extends BehaviourTransition {

	new(String name, IBehaviourState fromState, IBehaviourState toState) {
		super(name, fromState, toState)
	}

}