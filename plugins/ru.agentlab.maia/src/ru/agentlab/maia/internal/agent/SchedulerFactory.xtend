package ru.agentlab.maia.internal.agent

import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.agent.ISchedulerFactory
import ru.agentlab.maia.context.IContextFactory

class SchedulerFactory implements ISchedulerFactory {

	/**
	 * Remove all behaviours from old scheduler and add new Scheduler to context
	 */
	override IScheduler create(IEclipseContext context) {
		val name = context.get(IContextFactory.KEY_NAME) as String
		val oldScheduler = context.get(IScheduler)
		if (oldScheduler != null) {
			oldScheduler.removeAll
		}
		val newScheduler = new Scheduler(name)
		context.set(IScheduler, newScheduler)
		return newScheduler
	}

}
