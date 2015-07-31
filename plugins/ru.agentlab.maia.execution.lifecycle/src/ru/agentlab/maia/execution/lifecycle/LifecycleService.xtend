package ru.agentlab.maia.execution.lifecycle

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IMaiaContext

class LifecycleService implements IMaiaContextLifecycleService {

	@Inject
	IMaiaContext context

	@Accessors
	@Inject
	IMaiaContextLifecycleScheme scheme

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
		val transition = scheme.transitions.findFirst[toState == state]
		if (transition != null) {
			transition.internalTransit
		} else {
			throw new IllegalStateException(
				"LifeCycleScheme [" + scheme + "] have no transition to [" + state.name + "] state")
		}
	}

	override invokeTransition(IMaiaContextLifecycleTransition transition) throws IllegalStateException {
		if (scheme.transitions.findFirst[it == transition] != null) {
			throw new IllegalStateException("LifeCycleSchema [" + scheme + "] have no transition [" + transition + "]")
		}
		transition.internalTransit
	}

	def void internalTransit(IMaiaContextLifecycleTransition transition) {
		if (currentState == transition.fromState) {
			context.set(IMaiaContextLifecycleState, transition.toState)
		} else {
			throw new IllegalStateException(
				"Can't invoke [" + transition + "] Transition from current state [" + currentState + "]")
		}
	}

}