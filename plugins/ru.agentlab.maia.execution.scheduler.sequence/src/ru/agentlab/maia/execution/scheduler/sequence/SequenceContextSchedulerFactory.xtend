package ru.agentlab.maia.execution.scheduler.sequence

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.execution.scheduler.IMaiaContextSchedulerFactory
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.scheduler.unbounded.IMaiaUnboundedContextScheduler

class SequenceContextSchedulerFactory implements IMaiaContextSchedulerFactory {

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

		val oldScheduler = context.get(IMaiaUnboundedContextScheduler)
		if (oldScheduler != null) {
			oldScheduler.removeAll
		}

		val newScheduler = injector.make(SequenceContextScheduler, context)
		injector.invoke(newScheduler, PostConstruct, context, null)
		context.set(IMaiaExecutorScheduler, newScheduler)
		return newScheduler
	}

}
