package ru.agentlab.maia.behaviour.scheme.lib

import ru.agentlab.maia.execution.scheduler.scheme.SchedulingScheme
import ru.agentlab.maia.execution.scheduler.scheme.SchedulingState
import ru.agentlab.maia.execution.scheduler.scheme.SchedulingTransitionDefault
import ru.agentlab.maia.execution.scheduler.scheme.SchedulingTransitionException

class BehaviourSchemeCyclic extends SchedulingScheme {

	val public static STATE_MAIN = new SchedulingState("MAIN")

	val public static TRANSITION_START = new SchedulingTransitionDefault("START", STATE_INITIAL, STATE_MAIN)

	val public static TRANSITION_CYCLE = new SchedulingTransitionDefault("CYCLE", STATE_MAIN, STATE_MAIN)

	val public static TRANSITION_EXCEPTION = new SchedulingTransitionException(Exception, STATE_MAIN, STATE_FINAL)

	override protected getStates() {
		return #[
			STATE_MAIN
		]
	}

	override protected getTransitions() {
		return #[
			TRANSITION_START,
			TRANSITION_CYCLE,
			TRANSITION_EXCEPTION
		]
	}

}