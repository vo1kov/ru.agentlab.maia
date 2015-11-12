package ru.agentlab.maia.behaviour.fsm

import ru.agentlab.maia.behaviour.IBehaviour

class ExceptionFsmTransition extends AbstractFsmTransition {

	Class<? extends RuntimeException> exception

	new(IBehaviour from, IBehaviour to, Class<? extends RuntimeException> exc) {
		super(from, to)
		this.exception = exc
	}

}