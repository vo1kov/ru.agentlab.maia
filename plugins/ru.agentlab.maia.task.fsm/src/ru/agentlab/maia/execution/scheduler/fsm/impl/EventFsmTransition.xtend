package ru.agentlab.maia.execution.scheduler.fsm.impl

import ru.agentlab.maia.execution.ITask

class EventFsmTransition extends AbstractFsmTransition {

	String topic

	new(ITask from, ITask to, String topic) {
		super(from, to)
		this.topic = topic
	}

}