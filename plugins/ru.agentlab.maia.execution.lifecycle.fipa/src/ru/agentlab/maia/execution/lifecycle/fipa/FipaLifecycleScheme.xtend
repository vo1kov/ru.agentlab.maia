package ru.agentlab.maia.execution.lifecycle.fipa

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.lifecycle.ILifecycleScheme
import ru.agentlab.maia.execution.lifecycle.ILifecycleState
import ru.agentlab.maia.execution.lifecycle.LifecycleScheme
import ru.agentlab.maia.execution.lifecycle.LifecycleState
import ru.agentlab.maia.execution.lifecycle.LifecycleTransition

class FipaLifecycleScheme extends LifecycleScheme {

	val public static STATE_UNKNOWN = ILifecycleState.STATE_UNKNOWN

	val public static STATE_ACTIVE = new LifecycleState("ACTIVE")

	val public static STATE_SUSPENDED = new LifecycleState("SUSPENDED")

	val public static STATE_INITIATED = new LifecycleState("INITIATED")

	val public static STATE_DELETED = new LifecycleState("DELETED")

	val public static TRANSITION_INVOKE = new LifecycleTransition("INVOKE", STATE_UNKNOWN, STATE_ACTIVE)

	val public static TRANSITION_SUSPEND = new LifecycleTransition("SUSPEND", STATE_ACTIVE, STATE_SUSPENDED)

	val public static TRANSITION_RESUME = new LifecycleTransition("RESUME", STATE_SUSPENDED, STATE_ACTIVE)

	val public static TRANSITION_DELETE = new LifecycleTransition("DELETE", STATE_ACTIVE, STATE_DELETED)

	@Inject
	IMaiaContext context

	@PostConstruct
	def void init() {
		context.set(ILifecycleScheme, null)

		states += STATE_UNKNOWN
		states += STATE_INITIATED
		states += STATE_ACTIVE
		states += STATE_SUSPENDED
		states += STATE_DELETED

		initialState = STATE_INITIATED
		finalState = STATE_DELETED

		transitions += TRANSITION_INVOKE
		transitions += TRANSITION_SUSPEND
		transitions += TRANSITION_RESUME
		transitions += TRANSITION_DELETE
	}

}