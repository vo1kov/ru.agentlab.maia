package ru.agentlab.maia.behaviour.fsm

import ru.agentlab.maia.behaviour.IExecutionStep

class ExceptionFsmTransition extends AbstractFsmTransition {

	new(IExecutionStep from, IExecutionStep to) {
		super(from, to)
	}

}
