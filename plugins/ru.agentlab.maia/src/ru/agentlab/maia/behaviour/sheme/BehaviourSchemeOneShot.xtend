package ru.agentlab.maia.behaviour.sheme

class BehaviourSchemeOneShot extends BehaviourScheme {

	val public static STATE_MAIN = new BehaviourState("MAIN")

	val public static TRANSITION_START = new BehaviourTransitionDefault("START", STATE_INITIAL, STATE_MAIN)

	val public static TRANSITION_FINISH = new BehaviourTransitionDefault("FINISH", STATE_MAIN, STATE_FINAL)

	override void init() {
		super.init
		states += STATE_MAIN

		transitions += TRANSITION_START
		transitions += TRANSITION_FINISH
	}
}