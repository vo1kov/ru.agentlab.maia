package ru.agentlab.maia.task.fsm

import ru.agentlab.maia.task.ITask

class EventFsmTransition extends AbstractFsmTransition {

	String topic

	new(ITask from, ITask to, String topic) {
		super(from, to)
		this.topic = topic
	}

}