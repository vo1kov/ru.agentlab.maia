package ru.agentlab.maia.behaviour.fsm

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IExecutionStep

class EventFsmTransition extends AbstractFsmTransition {

	@Accessors
	String topic

	new(IExecutionStep from, IExecutionStep to, String topic) {
		super(from, to)
		this.topic = topic
	}

}
