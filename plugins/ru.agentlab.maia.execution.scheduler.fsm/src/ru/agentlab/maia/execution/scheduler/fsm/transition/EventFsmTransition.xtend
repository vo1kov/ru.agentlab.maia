package ru.agentlab.maia.execution.scheduler.fsm.transition

import ru.agentlab.maia.execution.tree.IExecutionNode

class EventFsmTransition extends FsmTransition {

	new(String name, IExecutionNode from, IExecutionNode to) {
		super(name, from, to)
	}

}