package ru.agentlab.maia.task.fsm

import ru.agentlab.maia.task.ITask

class ExceptionFsmTransition extends AbstractFsmTransition {

	Class<? extends RuntimeException> exception

	new(ITask from, ITask to, Class<? extends RuntimeException> exc) {
		super(from, to)
		this.exception = exc
	}

}