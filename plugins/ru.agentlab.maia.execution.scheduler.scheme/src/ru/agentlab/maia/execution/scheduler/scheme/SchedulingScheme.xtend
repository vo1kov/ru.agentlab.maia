package ru.agentlab.maia.execution.scheduler.scheme

import java.util.ArrayList
import java.util.Collection
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class SchedulingScheme implements IMaiaContextSchedulerScheme {

	val public static STATE_INITIAL = new SchedulingState("INITIAL")

	val public static STATE_FINAL = new SchedulingState("FINAL")

	val public static STATE_UNHANDLED_EXCEPTION = new SchedulingState("UNHANDLED_EXCEPTION")

	val public static TRANSITION_EXCEPTION = new SchedulingTransitionDefault("TRANSITION_EXCEPTION",
		STATE_UNHANDLED_EXCEPTION, STATE_FINAL)

	val List<IMaiaContextSchedulerState> allStates = new ArrayList<IMaiaContextSchedulerState>

	val List<IMaiaContextSchedulerTransition> allTransitions = new ArrayList<IMaiaContextSchedulerTransition>

	IMaiaContextSchedulerState initialState = STATE_INITIAL

	IMaiaContextSchedulerState finalState = STATE_FINAL

	var IMaiaContextSchedulerState currentState = initialState

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

	def protected Collection<IMaiaContextSchedulerState> getStates()

	def protected Collection<IMaiaContextSchedulerTransition> getTransitions()

	override getName() {
		this.class.name
	}

	override IMaiaContextSchedulerState getNextState(Object status) {
		val transitions = getPossibleTransitions
		if (status instanceof Exception) {
			return status.class.getNextExceptionState
		}
		var next = transitions.findFirst[it instanceof SchedulingTransitionStatus]
		if (next == null) {
			next = transitions.findFirst[it instanceof SchedulingTransitionEvent]
			if (next == null) {
				next = transitions.findFirst[it instanceof SchedulingTransitionDefault]
			}
		}
		return next.toState
	}

	def private IMaiaContextSchedulerState getNextExceptionState(Class<? extends Exception> exceptionClass) {
		val transition = transitions.findFirst [
			if (it instanceof SchedulingTransitionException) {
				return exceptionClass.isAssignableFrom(it.throwable) && fromState == currentState
			} else {
				return false
			}
		]
		transition?.toState
	}

	def private Iterable<IMaiaContextSchedulerTransition> getPossibleTransitions() {
		return transitions.filter[fromState == currentState]
	}

}