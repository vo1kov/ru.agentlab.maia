package ru.agentlab.maia.execution.scheduler.scheme.internal

import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingState

class DefaultSchedulingTransition extends SchedulingTransition {

	new(String name, ISchedulingState fromState, ISchedulingState toState) {
		super(name, fromState, toState)
	}

}