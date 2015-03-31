package ru.agentlab.maia.internal.behaviour

import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.Action
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.sheme.BehaviourScheme
import ru.agentlab.maia.behaviour.sheme.BehaviourSchemeException
import ru.agentlab.maia.behaviour.sheme.BehaviourStateEmpty
import ru.agentlab.maia.behaviour.sheme.BehaviourStateFinal
import ru.agentlab.maia.behaviour.sheme.BehaviourStateImplement
import ru.agentlab.maia.behaviour.sheme.BehaviourTaskMappingException
import ru.agentlab.maia.behaviour.sheme.BehaviourTransitionDefault
import ru.agentlab.maia.behaviour.sheme.BehaviourTransitionException
import ru.agentlab.maia.behaviour.sheme.BehaviourTransitionStatus
import ru.agentlab.maia.behaviour.sheme.IBehaviourScheme
import ru.agentlab.maia.behaviour.sheme.IBehaviourState
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMapping

class Behaviour implements IBehaviour {

	@Inject
	IEclipseContext context

	@Inject
	IBehaviourScheme actionScheme

	@Inject
	IBehaviourTaskMapping actionMapping

	@Inject
	IScheduler scheduler

	IBehaviourState currentState = BehaviourScheme.STATE_INITIAL

	override void action() {
		if (currentState == actionScheme.initialState) {
			currentState = getNextState(null)
		}
		val contributor = switch (currentState) {
			BehaviourStateFinal: {
				val c = actionScheme.getDefaultTask(currentState)
				if (c == null) {
					throw new BehaviourSchemeException("Scheme have no default mapping for [" + currentState +
						"] state")
				}
				c
			}
			BehaviourStateImplement: {
				val c = actionMapping.get(currentState)
				if (c == null) {
					throw new BehaviourTaskMappingException("Mapping have no required value for [" + currentState +
						"] state")
				}
				c
			}
			BehaviourStateEmpty: {
				var c = actionMapping.get(currentState)
				if (c == null) {
					c = actionScheme.getDefaultTask(currentState)
				}
				c
			}
		}
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
		if (nextState == actionScheme.finalState) {
			scheduler.remove(this)
		}
		if (currentState != BehaviourScheme.STATE_FINAL) {
			if (nextState == null) {
				throw new IllegalStateException("Action state [" + currentState + "] have no transition to next state")
			}
		} else {
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