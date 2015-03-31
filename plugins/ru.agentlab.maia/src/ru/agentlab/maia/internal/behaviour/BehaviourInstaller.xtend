package ru.agentlab.maia.internal.behaviour

import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.contexts.RunAndTrack
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IScheduler

/**
 * Track IScheduler object in context. If scheduler change then
 * add behaviour to the new one.
 */
class BehaviourInstaller extends RunAndTrack {

	val static LOGGER = LoggerFactory.getLogger(BehaviourInstaller)

	override changed(IEclipseContext context) {
		val scheduler = context.get(IScheduler)
		LOGGER.info("Scheduler have changed. New value [{}]", scheduler)
		if (scheduler != null) {
			LOGGER.info("Add Behaviour to agent scheduler...")
			scheduler.add(context)
		} else {
			LOGGER.info("Root context [{}] have no scheduler", context.parent)
		}
		return true
	}

}