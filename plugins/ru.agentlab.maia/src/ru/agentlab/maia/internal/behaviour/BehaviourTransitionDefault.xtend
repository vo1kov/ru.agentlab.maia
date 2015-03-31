package ru.agentlab.maia.internal.behaviour

import ru.agentlab.maia.behaviour.IBehaviourState

class BehaviourTransitionDefault extends BehaviourTransition {

	new(String name, IBehaviourState fromState, IBehaviourState toState) {
		super(name, fromState, toState)
	}

}