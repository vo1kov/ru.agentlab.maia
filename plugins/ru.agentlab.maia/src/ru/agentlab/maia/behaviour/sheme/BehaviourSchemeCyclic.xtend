package ru.agentlab.maia.behaviour.sheme

class BehaviourSchemeCyclic extends BehaviourScheme {

	val public static STATE_MAIN = new BehaviourStateEmpty("MAIN")

	val public static TRANSITION_START = new BehaviourTransitionDefault("START", STATE_INITIAL, STATE_MAIN)

	val public static TRANSITION_CYCLE = new BehaviourTransitionDefault("CYCLE", STATE_MAIN, STATE_MAIN)

	val public static TRANSITION_EXCEPTION = new BehaviourTransitionException(Exception, STATE_MAIN, STATE_FINAL)

	override protected void init() {
		super.init
		states += STATE_MAIN

		transitions += TRANSITION_START
		transitions += TRANSITION_CYCLE
		transitions += TRANSITION_EXCEPTION
	}

}