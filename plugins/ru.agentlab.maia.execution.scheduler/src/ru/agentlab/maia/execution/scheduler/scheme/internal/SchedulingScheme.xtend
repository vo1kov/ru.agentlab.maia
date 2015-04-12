package ru.agentlab.maia.execution.scheduler.scheme.internal

import java.util.ArrayList
import java.util.Collection
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingTransition
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingState
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingScheme

@Accessors
abstract class SchedulingScheme implements ISchedulingScheme {

	val public static STATE_INITIAL = new SchedulingState("INITIAL")

	val public static STATE_FINAL = new SchedulingState("FINAL")

	val public static STATE_UNHANDLED_EXCEPTION = new SchedulingState("UNHANDLED_EXCEPTION")

	val public static TRANSITION_EXCEPTION = new DefaultSchedulingTransition("TRANSITION_EXCEPTION",
		STATE_UNHANDLED_EXCEPTION, STATE_FINAL)

	val List<ISchedulingState> allStates = new ArrayList<ISchedulingState>

	val List<ISchedulingTransition> allTransitions = new ArrayList<ISchedulingTransition>

	ISchedulingState initialState = STATE_INITIAL

	ISchedulingState finalState = STATE_FINAL

	var ISchedulingState currentState = initialState

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

	def protected Collection<ISchedulingState> getStates()

	def protected Collection<ISchedulingTransition> getTransitions()

	override getName() {
		this.class.name
	}

	override ISchedulingState getNextState(Object status) {
		val transitions = getPossibleTransitions
		if (status instanceof Exception) {
			return status.class.getNextExceptionState
		}
		var next = transitions.findFirst[it instanceof StatusSchedulingTransition]
		if (next == null) {
			next = transitions.findFirst[it instanceof EventSchedulingTransition]
			if (next == null) {
				next = transitions.findFirst[it instanceof DefaultSchedulingTransition]
			}
		}
		return next.toState
	}

	def private ISchedulingState getNextExceptionState(Class<? extends Exception> exceptionClass) {
		val transition = transitions.findFirst [
			if (it instanceof ExceptionSchedulingTransition) {
				return exceptionClass.isAssignableFrom(it.throwable) && fromState == currentState
			} else {
				return false
			}
		]
		transition?.toState
	}

	def private Iterable<ISchedulingTransition> getPossibleTransitions() {
		return transitions.filter[fromState == currentState]
	}

}