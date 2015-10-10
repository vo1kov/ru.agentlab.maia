package ru.agentlab.maia.execution.scheduler.fsm.impl

import ru.agentlab.maia.execution.ITask

class ExceptionFsmTransition extends AbstractFsmTransition {

	Class<? extends RuntimeException> exception

	new(ITask from, ITask to, Class<? extends RuntimeException> exc) {
		super(from, to)
		this.exception = exc
	}

}