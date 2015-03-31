package ru.agentlab.maia.internal.behaviour

import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.Action
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourScheme
import ru.agentlab.maia.behaviour.IBehaviourState
import ru.agentlab.maia.behaviour.IBehaviourTaskMapping

class Behaviour implements IBehaviour {

	@Inject
	IEclipseContext context

	@Inject
	IBehaviourScheme actionScheme

	@Inject
	IBehaviourTaskMapping actionMapping

	IBehaviourState currentState = BehaviourScheme.STATE_INITIAL

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
		if (currentState != BehaviourScheme.STATE_FINAL) {
			if (nextState == null) {
				throw new IllegalStateException("Action state [" + currentState + "] have no transition to next state")
			}
		}
		currentState = nextState
	}

	def private IBehaviourState getNextState(Object status) {
		val transitionDefault = actionScheme.transitions.findFirst [
			if (it instanceof BehaviourTransitionDefault) {
				return fromState == currentState
			} else {
				return false
			}
		]
		if (transitionDefault != null) {
			return transitionDefault.toState
		} else {
			val transitionStatus = actionScheme.transitions.findFirst [
				if (it instanceof BehaviourTransitionStatus) {
					return fromState == currentState && it.status == status
				} else {
					return false
				}
			]
			return transitionStatus?.toState
		}
	}

	def private IBehaviourState getNextExceptionState(Class<? extends Exception> exceptionClass) {
		val transition = actionScheme.transitions.findFirst [
			if (it instanceof BehaviourTransitionException) {
				return exceptionClass.isAssignableFrom(it.throwable) && fromState == currentState
			} else {
				return false
			}
		]
		transition?.toState
	}
}