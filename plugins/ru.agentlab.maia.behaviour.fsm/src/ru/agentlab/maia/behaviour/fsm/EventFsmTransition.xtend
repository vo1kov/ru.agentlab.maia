package ru.agentlab.maia.behaviour.fsm

import ru.agentlab.maia.behaviour.IBehaviour

class EventFsmTransition extends AbstractFsmTransition {

	String topic

	new(IBehaviour from, IBehaviour to, String topic) {
		super(from, to)
		this.topic = topic
	}

}