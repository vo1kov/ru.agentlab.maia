package ru.agentlab.maia.internal.behaviour

class ActionSchemeCyclic extends ActionScheme {

	val public static STATE_MAIN = new ActionState("MAIN")

	val public static TRANSITION_START = new TransitionDefault("START", STATE_INITIAL, STATE_MAIN)

	val public static TRANSITION_CYCLE = new TransitionDefault("CYCLE", STATE_MAIN, STATE_MAIN)

	val public static TRANSITION_EXCEPTION = new TransitionException(Exception, STATE_MAIN, STATE_FINAL)

	override void init() {
		super.init
		states += STATE_MAIN

		transitions += TRANSITION_START
		transitions += TRANSITION_CYCLE
		transitions += TRANSITION_EXCEPTION
	}
	
}