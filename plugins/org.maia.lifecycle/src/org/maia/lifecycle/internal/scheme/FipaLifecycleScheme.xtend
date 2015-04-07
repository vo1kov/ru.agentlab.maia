package org.maia.lifecycle.internal.scheme

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.maia.lifecycle.scheme.ILifecycleScheme
import org.maia.lifecycle.scheme.ILifecycleState

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
	IEclipseContext context

	@PostConstruct
	def void init() {
		context.declareModifiable(ILifecycleScheme)

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