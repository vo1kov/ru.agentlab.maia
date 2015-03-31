package ru.agentlab.maia.internal.behaviour

import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.Action
import ru.agentlab.maia.behaviour.IActionMapping
import ru.agentlab.maia.behaviour.IActionScheme
import ru.agentlab.maia.behaviour.IActionState
import ru.agentlab.maia.behaviour.IBehaviourActionService

class BehaviourActionService implements IBehaviourActionService {

	@Inject
	IEclipseContext context

	@Inject
	IActionScheme actionScheme

	@Inject
	IActionMapping actionMapping

	IActionState currentState = ActionScheme.STATE_INITIAL

	override void action() {
		val contributor = actionMapping.get(currentState)
		val nextState = try {
			val result = if (contributor != null) {
				ContextInjectionFactory.invoke(contributor, Action, context)
			} else {
				null
			}
			getNextState(result)
		} catch (Exception e) {
			getNextExceptionState(e.class)
		}
		if(currentState != ActionScheme.STATE_FINAL){
			if (nextState == null) {
				throw new IllegalStateException("Action state [" + currentState + "] have no transition to next state")
			}
		}
		currentState = nextState
	}

	def private IActionState getNextState(Object status) {
		val transitionDefault = actionScheme.transitions.findFirst [
			if (it instanceof TransitionDefault) {
				return fromState == currentState
			} else {
				return false
			}
		]
		if (transitionDefault != null) {
			return transitionDefault.toState
		} else {
			val transitionStatus = actionScheme.transitions.findFirst [
				if (it instanceof TransitionStatus) {
					return fromState == currentState && it.status == status
				} else {
					return false
				}
			]
			return transitionStatus?.toState
		}
	}

	def private IActionState getNextExceptionState(Class<? extends Exception> exceptionClass) {
		val transition = actionScheme.transitions.findFirst [
			if (it instanceof TransitionException) {
				return exceptionClass.isAssignableFrom(it.throwable) && fromState == currentState
			} else {
				return false
			}
		]
		transition?.toState
	}
}