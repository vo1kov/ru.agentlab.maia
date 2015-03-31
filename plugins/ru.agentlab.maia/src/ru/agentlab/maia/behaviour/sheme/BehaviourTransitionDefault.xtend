package ru.agentlab.maia.behaviour.sheme

import ru.agentlab.maia.behaviour.IBehaviourState

class BehaviourTransitionDefault extends BehaviourTransition {

	new(String name, IBehaviourState fromState, IBehaviourState toState) {
		super(name, fromState, toState)
	}

}