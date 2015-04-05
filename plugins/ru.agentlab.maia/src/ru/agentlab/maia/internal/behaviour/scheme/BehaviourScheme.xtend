package ru.agentlab.maia.internal.behaviour.scheme

import java.util.ArrayList
import java.util.HashMap
import java.util.List
import javax.annotation.PostConstruct
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.sheme.IBehaviourScheme
import ru.agentlab.maia.behaviour.sheme.IBehaviourState
import ru.agentlab.maia.behaviour.sheme.IBehaviourTransition

@Accessors
abstract class BehaviourScheme implements IBehaviourScheme {

	val public static STATE_INITIAL = new BehaviourStateFinal("INITIAL")

	val public static STATE_FINAL = new BehaviourStateFinal("FINAL")

	val public static STATE_UNHANDLED_EXCEPTION = new BehaviourStateFinal("UNHANDLED_EXCEPTION")

	val public static TRANSITION_EXCEPTION = new BehaviourTransitionDefault("TRANSITION_EXCEPTION",
		STATE_UNHANDLED_EXCEPTION, STATE_FINAL)

	val defaultMapping = new HashMap<IBehaviourState, Object>

	val List<IBehaviourState> states = new ArrayList<IBehaviourState>

	val List<IBehaviourTransition> transitions = new ArrayList<IBehaviourTransition>

	IBehaviourState initialState

	IBehaviourState finalState

	@PostConstruct
	def protected void init() {
		initialState = STATE_INITIAL
		finalState = STATE_FINAL

		states += STATE_INITIAL
		states += STATE_FINAL
		states += STATE_UNHANDLED_EXCEPTION

		transitions += TRANSITION_EXCEPTION
	}

	override getName() {
		this.class.name
	}

	override Object getDefaultTask(IBehaviourState state) {
		return defaultMapping.get(state)
	}

}