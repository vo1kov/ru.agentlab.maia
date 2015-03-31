package ru.agentlab.maia.internal.behaviour

class ActionSchemeTicker extends ActionScheme {

	val public static STATE_MAIN = new ActionState("MAIN")

	val public static STATE_WAIT = new ActionState("WAIT")

	val public static TRANSITION_START = new TransitionDefault("START", STATE_INITIAL, STATE_MAIN)

	val public static TRANSITION_DELAY = new TransitionDefault("DELAY", STATE_MAIN, STATE_WAIT)

	val public static TRANSITION_CYCLE = new TransitionDefault("CYCLE", STATE_WAIT, STATE_MAIN)

	val public static TRANSITION_FINISH = new TransitionException(Exception, STATE_MAIN, STATE_FINAL)

	val public static TRANSITION_FINISH2 = new TransitionException(Exception, STATE_WAIT, STATE_FINAL)

	override void init() {
		super.init
		states += STATE_MAIN
		states += STATE_WAIT

		transitions += TRANSITION_START
		transitions += TRANSITION_CYCLE
		transitions += TRANSITION_FINISH
		transitions += TRANSITION_FINISH2
	}

}