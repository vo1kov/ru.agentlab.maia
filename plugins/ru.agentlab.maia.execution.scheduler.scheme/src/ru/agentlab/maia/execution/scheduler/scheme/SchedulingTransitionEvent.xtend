package ru.agentlab.maia.execution.scheduler.scheme

class SchedulingTransitionEvent extends SchedulingTransition {

	String topic

	new(String topic, String name, IMaiaContextSchedulerState fromState, IMaiaContextSchedulerState toState) {
		super(name, fromState, toState)
		this.topic = topic
	}

}