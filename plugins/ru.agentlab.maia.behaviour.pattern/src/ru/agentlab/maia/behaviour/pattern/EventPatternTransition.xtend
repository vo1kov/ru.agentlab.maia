package ru.agentlab.maia.behaviour.pattern

class EventPatternTransition extends AbstractPatternTransition {

	String topic

	new(String topic, String name, PatternState fromState, PatternState toState) {
		super(name, fromState, toState)
		this.topic = topic
	}

}