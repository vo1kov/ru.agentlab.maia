package ru.agentlab.maia.execution.lifecycle

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.event.IMaiaEventBroker
import ru.agentlab.maia.execution.lifecycle.event.MaiaLifecycleStateChangeEvent

class LifecycleService implements IMaiaContextLifecycleService {

	val static LOGGER = LoggerFactory.getLogger(LifecycleService)

	@Inject
	IMaiaContext context

	@Accessors
	@Inject
	IMaiaContextLifecycleScheme scheme

	@Inject
	IMaiaEventBroker eventBroker

	@PostConstruct
	def void init() {
		val old = context.getLocal(IMaiaContextLifecycleState)
		if (old == null) {
			context.set(IMaiaContextLifecycleState, scheme.initialState)
		}
	}

	override getCurrentState() {
		context.get(IMaiaContextLifecycleState)
	}

	override void setState(IMaiaContextLifecycleState state) {
		LOGGER.info("Try to set new State [{}]...", state)
		val transition = scheme.transitions.findFirst[toState == state]
		if (transition != null) {
			transition.internalTransit
		} else {
			throw new IllegalStateException(
				"LifeCycleScheme [" + scheme + "] have no transition to [" + state.name + "] state")
		}
	}

	override invokeTransition(IMaiaContextLifecycleTransition transition) throws IllegalStateException {
		LOGGER.info("Try to invoke transition [{}]...", transition)
		if (scheme.transitions.findFirst[it == transition] != null) {
			throw new IllegalStateException("LifeCycleSchema [" + scheme + "] have no transition [" + transition + "]")
		}
		transition.internalTransit
	}

	def void internalTransit(IMaiaContextLifecycleTransition transition) {
		if (currentState == transition.fromState) {
			context.set(IMaiaContextLifecycleState, transition.toState)
			eventBroker.post(new MaiaLifecycleStateChangeEvent(context, transition.fromState, transition.toState))
		} else {
			throw new IllegalStateException(
				"Can't invoke [" + transition + "] Transition from current state [" + currentState + "]")
		}
	}

}