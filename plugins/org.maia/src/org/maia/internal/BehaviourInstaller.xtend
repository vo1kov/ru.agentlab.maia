package org.maia.internal

import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.contexts.RunAndTrack
import org.maia.behaviour.scheduler.IScheduler
import org.slf4j.LoggerFactory

/**
 * Track IScheduler object in context. If scheduler change then
 * add behaviour to the new one.
 */
class BehaviourInstaller extends RunAndTrack {

	val static LOGGER = LoggerFactory.getLogger(BehaviourInstaller)

	override changed(IEclipseContext context) {
		val scheduler = context.get(IScheduler)
		LOGGER.info("Scheduler have changed. New value [{}], [{}]", scheduler, scheduler.hashCode)
		if (scheduler != null) {
			LOGGER.info("Add Behaviour [{}] to agent scheduler [{}]...", context, scheduler)
			scheduler.add(context)
		} else {
			LOGGER.info("Root context [{}] have no scheduler", context.parent)
		}
		return true
	}

}