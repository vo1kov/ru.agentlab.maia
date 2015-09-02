package ru.agentlab.maia.execution.scheduler.fsm.impl

import ru.agentlab.maia.execution.tree.IExecutionNode

class ExceptionFsmTransition extends AbstractFsmTransition {

	Class<? extends RuntimeException> exception

	new(IExecutionNode from, IExecutionNode to, Class<? extends RuntimeException> exc) {
		super(from, to)
		this.exception = exc
	}

}