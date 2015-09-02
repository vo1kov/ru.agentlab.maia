package ru.agentlab.maia.execution.scheduler.pattern

import java.util.ArrayList
import java.util.Collection
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.scheduler.pattern.state.PatternState
import ru.agentlab.maia.execution.scheduler.pattern.transition.AbstractPatternTransition
import ru.agentlab.maia.execution.scheduler.pattern.transition.DefaultPatternTransition
import ru.agentlab.maia.execution.scheduler.pattern.transition.EventPatternTransition
import ru.agentlab.maia.execution.scheduler.pattern.transition.ExceptionPatternTransition
import ru.agentlab.maia.execution.scheduler.pattern.transition.StatusPatternTransition

@Accessors
abstract class PatternScheme {

	val public static STATE_INITIAL = new PatternState("INITIAL")

	val public static STATE_FINAL = new PatternState("FINAL")

	val public static STATE_UNHANDLED_EXCEPTION = new PatternState("UNHANDLED_EXCEPTION")

	val public static TRANSITION_EXCEPTION = new DefaultPatternTransition("TRANSITION_EXCEPTION",
		STATE_UNHANDLED_EXCEPTION, STATE_FINAL)

	val List<PatternState> allStates = new ArrayList<PatternState>

	val List<AbstractPatternTransition> allTransitions = new ArrayList<AbstractPatternTransition>

	PatternState initialState = STATE_INITIAL

	PatternState finalState = STATE_FINAL

	var PatternState currentState = initialState

	new() {
		init
	}

	def private void init() {
		allStates += STATE_INITIAL
		allStates += STATE_FINAL
		allStates += STATE_UNHANDLED_EXCEPTION
		allStates += states

		allTransitions += TRANSITION_EXCEPTION
		allTransitions += transitions
	}

	def protected Collection<PatternState> getStates()

	def protected Collection<AbstractPatternTransition> getTransitions()

	def getName() {
		this.class.name
	}

	def PatternState getNextState(Object status) {
		val transitions = getPossibleTransitions
		if (status instanceof Exception) {
			return status.class.getNextExceptionState
		}
		var next = transitions.findFirst[it instanceof StatusPatternTransition]
		if (next == null) {
			next = transitions.findFirst[it instanceof EventPatternTransition]
			if (next == null) {
				next = transitions.findFirst[it instanceof DefaultPatternTransition]
			}
		}
		return next.toState
	}

	def private PatternState getNextExceptionState(Class<? extends Exception> exceptionClass) {
		val transition = transitions.findFirst [
			if (it instanceof ExceptionPatternTransition) {
				return exceptionClass.isAssignableFrom(it.throwable) && fromState == currentState
			} else {
				return false
			}
		]
		transition?.toState
	}

	def private Iterable<AbstractPatternTransition> getPossibleTransitions() {
		return transitions.filter[fromState == currentState]
	}

}