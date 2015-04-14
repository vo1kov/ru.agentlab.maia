package ru.agentlab.maia.behaviour.scheme.lib

import ru.agentlab.maia.execution.scheduler.scheme.SchedulingScheme
import ru.agentlab.maia.execution.scheduler.scheme.SchedulingState
import ru.agentlab.maia.execution.scheduler.scheme.SchedulingTransitionDefault

class BehaviourSchemeOneShot extends SchedulingScheme {

	val public static STATE_MAIN = new SchedulingState("MAIN")

	val public static TRANSITION_START = new SchedulingTransitionDefault("START", STATE_INITIAL, STATE_MAIN)

	val public static TRANSITION_FINISH = new SchedulingTransitionDefault("FINISH", STATE_MAIN, STATE_FINAL)

	override protected getStates() {
		return #[
			STATE_MAIN
		]
	}

	override protected getTransitions() {
		return #[
			TRANSITION_START,
			TRANSITION_EXCEPTION
		]
	}

}