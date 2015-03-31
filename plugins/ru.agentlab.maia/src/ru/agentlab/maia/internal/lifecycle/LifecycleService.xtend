package ru.agentlab.maia.internal.lifecycle

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors
import org.slf4j.LoggerFactory
import ru.agentlab.maia.lifecycle.ILifecycleSchema
import ru.agentlab.maia.lifecycle.ILifecycleService
import ru.agentlab.maia.lifecycle.ILifecycleState
import ru.agentlab.maia.lifecycle.ILifecycleTransition

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

@Accessors(AccessorType.PUBLIC_GETTER)
class LifecycleService implements ILifecycleService {

	val static LOGGER = LoggerFactory.getLogger(LifecycleService)

	@Inject
	IEclipseContext context

	@Inject
	ILifecycleSchema schema

	ILifecycleState currentState = ILifecycleState.STATE_UNKNOWN

	@PostConstruct
	def void init() {
		context => [
			declareModifiable(ILifecycleState)
			declareModifiable(ILifecycleTransition)
			modify(ILifecycleState, currentState)
		]
	}

	override void setState(String stateName) {
		LOGGER.info("Try to set new state [{}]...", stateName)
		val schemaState = schema.states.findFirst[name == stateName]
		if (schemaState != null) {
			setState(schemaState)
		} else {
			throw new IllegalStateException(
				"LifeCycleSchema [" + schema + "] have no state with name [" + stateName + "]")
		}
	}

	override void setState(ILifecycleState state) {
		LOGGER.info("Try to set new State [{}]...", state)
		val transition = schema.transitions.findFirst[toState == state]
		if (transition != null) {
			if (currentState == transition.fromState) {
				// can change state
				context.modify(ILifecycleState, transition.toState)
				context.modify(ILifecycleTransition, transition)
			} else {
				throw new IllegalStateException(
					"Target state [" + state.name + "] is not reachable from current state [" + currentState + "]")
			}
		} else {
			throw new IllegalStateException(
				"LifeCycleSchema [" + schema + "] have no transition to [" + state.name + "] state")
		}
	}

	override invokeTransition(ILifecycleTransition transition) throws IllegalStateException {
		LOGGER.info("Try to invoke transition [{}]...", transition)
		val schemaTransition = schema.transitions.findFirst[it == transition]
		if (schemaTransition != null) {
			if (currentState == schemaTransition.fromState) {
				// can change state
				context.modify(ILifecycleState, schemaTransition.toState)
				context.modify(ILifecycleTransition, schemaTransition)
			} else {
				throw new IllegalStateException(
					"Can't invoke [" + transition + "] Transition from current state [" + currentState + "]")
			}
		} else {
			throw new IllegalStateException("LifeCycleSchema [" + schema + "] have no transition [" + transition + "]")
		}
	}

	override invokeTransition(String transitionName) throws IllegalStateException {
		LOGGER.info("Try to invoke transition with name [{}]...", transitionName)
		val schemaTransition = schema.transitions.findFirst[name == transitionName]
		if (schemaTransition != null) {
			invokeTransition(schemaTransition)
		} else {
			throw new IllegalStateException(
				"LifeCycleSchema [" + schema + "] have no transition with name [" + transitionName + "]")
		}
	}

}