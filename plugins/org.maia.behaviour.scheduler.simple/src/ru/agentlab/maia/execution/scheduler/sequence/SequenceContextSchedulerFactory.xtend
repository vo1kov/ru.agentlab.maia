package ru.agentlab.maia.execution.scheduler.sequence

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.IMaiaContext
import ru.agentlab.maia.agent.IAgentScheduler
import ru.agentlab.maia.injector.IMaiaContextInjector
import ru.agentlab.maia.execution.scheduler.IScheduler
import ru.agentlab.maia.execution.scheduler.ISchedulerFactory

class SequenceContextSchedulerFactory implements ISchedulerFactory {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	/**
	 * Remove all behaviours from old scheduler and add new Scheduler to context
	 */
	override createScheduler(IMaiaContext ctx) {
		val context = if (ctx != null) {
				ctx
			} else {
				this.context
			}

		val oldScheduler = context.get(IAgentScheduler)
		if (oldScheduler != null) {
			oldScheduler.removeAll
		}

		val newScheduler = injector.make(SequenceContextScheduler, context)
		injector.invoke(newScheduler, PostConstruct, context, null)
		context.set(IScheduler, newScheduler)
		return newScheduler
	}

}
