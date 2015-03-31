package ru.agentlab.maia.proto

import ru.agentlab.maia.behaviour.sheme.BehaviourScheme
import ru.agentlab.maia.behaviour.sheme.BehaviourStateFinal
import ru.agentlab.maia.behaviour.sheme.BehaviourStateImplement
import ru.agentlab.maia.behaviour.sheme.BehaviourTransitionDefault
import ru.agentlab.maia.behaviour.sheme.BehaviourTransitionException

class BehaviourSchemeInitiator extends BehaviourScheme {

	val public static STATE_MAIN = new BehaviourStateImplement("MAIN")

	val public static STATE_WAIT = new BehaviourStateFinal("WAIT")

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