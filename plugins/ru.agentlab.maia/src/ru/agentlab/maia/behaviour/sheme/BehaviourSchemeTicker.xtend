package ru.agentlab.maia.behaviour.sheme

class BehaviourSchemeTicker extends BehaviourScheme {

	val public static STATE_MAIN = new BehaviourState("MAIN")

	val public static STATE_WAIT = new BehaviourState("WAIT")

	val public static TRANSITION_START = new BehaviourTransitionDefault("START", STATE_INITIAL, STATE_MAIN)

	val public static TRANSITION_DELAY = new BehaviourTransitionDefault("DELAY", STATE_MAIN, STATE_WAIT)

	val public static TRANSITION_CYCLE = new BehaviourTransitionDefault("CYCLE", STATE_WAIT, STATE_MAIN)

	val public static TRANSITION_FINISH = new BehaviourTransitionException(Exception, STATE_MAIN, STATE_FINAL)

	val public static TRANSITION_FINISH2 = new BehaviourTransitionException(Exception, STATE_WAIT, STATE_FINAL)

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