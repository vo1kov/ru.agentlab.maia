package ru.agentlab.maia.internal.behaviour.scheme

import ru.agentlab.maia.behaviour.sheme.IBehaviourState
import ru.agentlab.maia.TaskInput

class BehaviourTransitionEvent extends BehaviourTransition {
	
	@TaskInput
	String topic
	
	new(String name, IBehaviourState fromState, IBehaviourState toState) {
		super(name, fromState, toState)
	}
	
}