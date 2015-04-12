package ru.agentlab.maia.protocol.lib

import ru.agentlab.maia.behaviour.scheme.internal.BehaviourStateFinal
import ru.agentlab.maia.behaviour.scheme.internal.BehaviourStateImplement
import ru.agentlab.maia.behaviour.scheme.internal.ContextSchedulerScheme
import ru.agentlab.maia.behaviour.scheme.internal.ContextSchedulerTransitionException
import ru.agentlab.maia.behaviour.scheme.internal.ContextSchedulerTransitionDefault

class BehaviourSchemeInitiator extends ContextSchedulerScheme {

	val public static STATE_MAIN = new BehaviourStateImplement("MAIN")

	val public static STATE_WAIT = new BehaviourStateFinal("WAIT")

	val public static TRANSITION_START = new ContextSchedulerTransitionDefault("START", STATE_INITIAL, STATE_MAIN)

	val public static TRANSITION_DELAY = new ContextSchedulerTransitionDefault("DELAY", STATE_MAIN, STATE_WAIT)

	val public static TRANSITION_CYCLE = new ContextSchedulerTransitionDefault("CYCLE", STATE_WAIT, STATE_MAIN)

	val public static TRANSITION_FINISH = new ContextSchedulerTransitionException(Exception, STATE_MAIN, STATE_FINAL)

	val public static TRANSITION_FINISH2 = new ContextSchedulerTransitionException(Exception, STATE_WAIT, STATE_FINAL)

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