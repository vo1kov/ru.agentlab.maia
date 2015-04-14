package ru.agentlab.maia.execution.lifecycle.fipa

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.event.IMaiaEventBroker
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleScheme
import ru.agentlab.maia.execution.lifecycle.LifecycleScheme
import ru.agentlab.maia.execution.lifecycle.LifecycleState
import ru.agentlab.maia.execution.lifecycle.LifecycleTransition
import ru.agentlab.maia.execution.lifecycle.event.MaiaLifecycleStateChangeEvent
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler

class FipaLifecycleScheme extends LifecycleScheme {

	val public static STATE_ACTIVE = new LifecycleState("ACTIVE")

	val public static STATE_SUSPENDED = new LifecycleState("SUSPENDED")

	val public static STATE_INITIATED = new LifecycleState("INITIATED")

	val public static STATE_DELETED = new LifecycleState("DELETED")

	val public static TRANSITION_INVOKE = new LifecycleTransition("INVOKE", STATE_INITIATED, STATE_ACTIVE)

	val public static TRANSITION_SUSPEND = new LifecycleTransition("SUSPEND", STATE_ACTIVE, STATE_SUSPENDED)

	val public static TRANSITION_RESUME = new LifecycleTransition("RESUME", STATE_SUSPENDED, STATE_ACTIVE)

	val public static TRANSITION_DELETE = new LifecycleTransition("DELETE", STATE_ACTIVE, STATE_DELETED)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaEventBroker eventBroker

	@PostConstruct
	def void init() {
		context.set(IMaiaContextLifecycleScheme, null)

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

		val scheduler = context.parent.get(IMaiaExecutorScheduler)

		eventBroker.subscribe(MaiaLifecycleStateChangeEvent.TOPIC, [
			val event = it as MaiaLifecycleStateChangeEvent
			val from = event.fromState
			val to = event.toState
			if (from == TRANSITION_INVOKE.fromState && to == TRANSITION_INVOKE.toState) {
				// invoke
//				scheduler.start
			} else if (from == TRANSITION_SUSPEND.fromState && to == TRANSITION_SUSPEND.toState) {
				// suspend
				scheduler.remove(context)
			} else if (from == TRANSITION_RESUME.fromState && to == TRANSITION_RESUME.toState) {
				// resume
//				scheduler.restartAll
			} else if (from == TRANSITION_DELETE.fromState && to == TRANSITION_DELETE.toState) {
				// delete
//				scheduler.removeAll
			}
		])
	}

}