package ru.agentlab.maia.execution.lifecycle.fipa

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleScheme
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleState
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleTransition
import ru.agentlab.maia.execution.lifecycle.LifecycleScheme
import ru.agentlab.maia.execution.lifecycle.LifecycleState
import ru.agentlab.maia.execution.lifecycle.LifecycleTransition

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

//	@Inject
//	IMaiaEventBroker eventBroker
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

//		val scheduler = context.parent.get(IMaiaExecutorScheduler)
//		eventBroker.subscribe(MaiaLifecycleStateChangeEvent.TOPIC, [
//			val event = it as MaiaLifecycleStateChangeEvent
//			val from = event.fromState
//			val to = event.toState
//			if (context == event.context) {
//				if (TRANSITION_INVOKE.isTransition(from, to)) {
//					// invoke
//					LOGGER.info("INVOKE")
//					val exeService = context.get(IMaiaExecutorService)
//					exeService.submitThread
//				// scheduler.start
//				} else if (TRANSITION_SUSPEND.isTransition(from, to)) {
//					// suspend
//					LOGGER.info("SUSPEND")
////					scheduler.remove(context)
//				} else if (TRANSITION_RESUME.isTransition(from, to)) {
//					// resume
//					LOGGER.info("RESUME")
//				// scheduler.restartAll
//				} else if (TRANSITION_DELETE.isTransition(from, to)) {
//					// delete
//					LOGGER.info("DELETE")
//				// scheduler.removeAll
//				}
//			}
//		])
	}

	def boolean isTransition(IMaiaContextLifecycleTransition transition, IMaiaContextLifecycleState fromState,
		IMaiaContextLifecycleState toState) {
		fromState == transition.fromState && toState == transition.toState
	}

}