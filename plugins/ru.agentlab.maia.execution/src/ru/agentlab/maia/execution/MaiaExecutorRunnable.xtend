package ru.agentlab.maia.execution

import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory

class MaiaExecutorRunnable implements IMaiaExecutorRunnable {

	val static LOGGER = LoggerFactory.getLogger(MaiaExecutorRunnable)

	IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	override run() {
		val contextType = context.get(IMaiaContextNameFactory.KEY_NAME) as String
		Thread.currentThread.name = context.get(IMaiaContextNameFactory.KEY_NAME) as String
		LOGGER.debug("Start Executor Runnable...")
		var currentContext = context
		var action = currentContext.get(IMaiaContextAction)
		LOGGER.debug("Test current context action...")
		LOGGER.debug("	Current action [{}]", action)
		while (currentContext != null && action == null) {
			val scheduler = currentContext.get(IMaiaExecutorScheduler)
			LOGGER.debug("Get context Scheduler...")
			LOGGER.debug("	Current Scheduler [{}]", scheduler)
//			synchronized (scheduler) {
				// get next context via scheduler that have no its own Executor service
				currentContext = scheduler.nextContext
				LOGGER.debug("	Current context: [{}]...", currentContext)
//				var executor = currentContext.get(IMaiaExecutorService)
//				// find context without it's own executor 
//				while (executor != null) {
//
//					// TODO: fix possible infinite loop
//					currentContext = scheduler.nextContext
//					executor = currentContext.get(IMaiaExecutorService)
//				}
				action = currentContext.get(IMaiaContextAction)
				LOGGER.debug("	Current action: [{}]...", action)
//			}
		}
		if (action != null) {
			action.beforeRun
			action.run
			action.afterRun
		}
	}
}