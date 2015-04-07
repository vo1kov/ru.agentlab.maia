package org.maia.behaviour.scheduler.simple.internal

import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.maia.IContextFactory
import org.maia.behaviour.scheduler.IScheduler
import org.maia.behaviour.scheduler.ISchedulerFactory

class SchedulerFactory implements ISchedulerFactory {

	@Inject
	IEclipseContext context

	/**
	 * Remove all behaviours from old scheduler and add new Scheduler to context
	 */
	override IScheduler create() {
		val name = context.getLocal(IContextFactory.KEY_NAME) as String
		val oldScheduler = context.get(IScheduler)
		if (oldScheduler != null) {
			oldScheduler.removeAll
		}
		val newScheduler = new Scheduler(name)
		context.set(IScheduler, newScheduler)
		return newScheduler
	}

}
