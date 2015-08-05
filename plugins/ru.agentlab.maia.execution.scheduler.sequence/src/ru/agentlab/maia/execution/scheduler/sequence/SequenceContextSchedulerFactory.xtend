package ru.agentlab.maia.execution.scheduler.sequence

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.execution.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.IMaiaExecutorSchedulerFactory
import ru.agentlab.maia.execution.scheduler.unbounded.IMaiaUnboundedExecutorScheduler

class SequenceContextSchedulerFactory implements IMaiaExecutorSchedulerFactory {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	/**
	 * Remove all behaviours from old scheduler and add new Scheduler to context
	 */
	override createScheduler() {
		val oldScheduler = context.get(IMaiaUnboundedExecutorScheduler)
		if (oldScheduler != null) {
			oldScheduler.removeAll
		}

		val newScheduler = injector.make(SequenceContextScheduler)
		injector.invoke(newScheduler, PostConstruct, null)
		context.set(IMaiaExecutorScheduler, newScheduler)
		return newScheduler
	}

}
