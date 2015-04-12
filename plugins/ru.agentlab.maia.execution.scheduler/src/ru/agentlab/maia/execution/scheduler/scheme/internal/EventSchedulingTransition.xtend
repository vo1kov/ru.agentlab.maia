package ru.agentlab.maia.execution.scheduler.scheme.internal

import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingState

class EventSchedulingTransition extends SchedulingTransition {

	String topic

	new(String topic, String name, ISchedulingState fromState, ISchedulingState toState) {
		super(name, fromState, toState)
		this.topic = topic
	}

}