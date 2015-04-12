package ru.agentlab.maia.behaviour.scheme.lib

import ru.agentlab.maia.execution.scheduler.scheme.internal.DefaultSchedulingTransition
import ru.agentlab.maia.execution.scheduler.scheme.internal.ExceptionSchedulingTransition
import ru.agentlab.maia.execution.scheduler.scheme.internal.SchedulingScheme
import ru.agentlab.maia.execution.scheduler.scheme.internal.SchedulingState

class BehaviourSchemeCyclic extends SchedulingScheme {

	val public static STATE_MAIN = new SchedulingState("MAIN")

	val public static TRANSITION_START = new DefaultSchedulingTransition("START", STATE_INITIAL, STATE_MAIN)

	val public static TRANSITION_CYCLE = new DefaultSchedulingTransition("CYCLE", STATE_MAIN, STATE_MAIN)

	val public static TRANSITION_EXCEPTION = new ExceptionSchedulingTransition(Exception, STATE_MAIN, STATE_FINAL)

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