package ru.agentlab.maia.execution.scheduler.fsm.impl

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.scheduler.fsm.IFsmTransition

@Accessors
abstract class AbstractFsmTransition implements IFsmTransition {

	IExecutionNode from

	IExecutionNode to

	new(IExecutionNode from, IExecutionNode to) {
		this.from = from
		this.to = to
	}

}