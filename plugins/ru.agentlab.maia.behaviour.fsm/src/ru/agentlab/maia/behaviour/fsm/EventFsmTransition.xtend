package ru.agentlab.maia.behaviour.fsm

import ru.agentlab.maia.behaviour.IBehaviour
import org.eclipse.xtend.lib.annotations.Accessors

class EventFsmTransition extends AbstractFsmTransition {

	@Accessors
	String topic

	new(IBehaviour from, IBehaviour to, String topic) {
		super(from, to)
		this.topic = topic
	}

}