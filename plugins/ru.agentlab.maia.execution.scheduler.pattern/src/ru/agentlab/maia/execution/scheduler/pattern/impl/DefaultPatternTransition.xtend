package ru.agentlab.maia.execution.scheduler.pattern.impl

import ru.agentlab.maia.execution.scheduler.pattern.state.PatternState

class DefaultPatternTransition extends AbstractPatternTransition {

	new(String name, PatternState fromState, PatternState toState) {
		super(name, fromState, toState)
	}

}