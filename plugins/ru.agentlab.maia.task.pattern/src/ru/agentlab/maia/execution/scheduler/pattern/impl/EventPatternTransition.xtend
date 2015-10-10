package ru.agentlab.maia.execution.scheduler.pattern.impl

class EventPatternTransition extends AbstractPatternTransition {

	String topic

	new(String topic, String name, PatternState fromState, PatternState toState) {
		super(name, fromState, toState)
		this.topic = topic
	}

}