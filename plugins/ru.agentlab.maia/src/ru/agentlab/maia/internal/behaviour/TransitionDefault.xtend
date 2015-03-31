package ru.agentlab.maia.internal.behaviour

import ru.agentlab.maia.behaviour.IActionState

class TransitionDefault extends ActionTransition {

	new(String name, IActionState fromState, IActionState toState) {
		super(name, fromState, toState)
	}

}