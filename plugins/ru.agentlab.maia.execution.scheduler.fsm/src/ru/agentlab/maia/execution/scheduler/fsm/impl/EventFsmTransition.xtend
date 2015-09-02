package ru.agentlab.maia.execution.scheduler.fsm.impl

import ru.agentlab.maia.execution.tree.IExecutionNode

class EventFsmTransition extends AbstractFsmTransition {

	String topic

	new(IExecutionNode from, IExecutionNode to, String topic) {
		super(from, to)
		this.topic = topic
	}

}