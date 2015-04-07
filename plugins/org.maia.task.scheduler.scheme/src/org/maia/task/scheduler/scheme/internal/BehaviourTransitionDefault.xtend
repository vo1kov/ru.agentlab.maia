package org.maia.task.scheduler.scheme.internal

import org.maia.task.scheduler.scheme.IBehaviourState

class BehaviourTransitionDefault extends BehaviourTransition {

	new(String name, IBehaviourState fromState, IBehaviourState toState) {
		super(name, fromState, toState)
	}

}