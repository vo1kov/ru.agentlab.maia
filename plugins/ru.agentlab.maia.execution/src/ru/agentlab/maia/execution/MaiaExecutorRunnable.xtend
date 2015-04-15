package ru.agentlab.maia.execution

import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.typing.IMaiaContextTyping

class MaiaExecutorRunnable implements IMaiaExecutorRunnable {

	val static LOGGER = LoggerFactory.getLogger(MaiaExecutorRunnable)

	var IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	override run() {
		val contextType = context.get(IMaiaContextTyping.KEY_TYPE) as String
		val contextName = context.get(IMaiaContextNameFactory.KEY_NAME) as String
		Thread.currentThread.name = contextType + ": " + contextName
		
		LOGGER.debug("Start Executor Runnable...")
		var currentContext = context
		LOGGER.debug("Current Context: [{}]", currentContext)
		var action = currentContext.get(IMaiaContextAction)
		LOGGER.debug("	current action [{}]", action)
		while (currentContext != null && action == null) {
			
//			Thread.sleep(20000)
			
			val scheduler = currentContext.get(IMaiaExecutorScheduler)
			LOGGER.debug("	current scheduler [{}]", scheduler)
//			synchronized (scheduler) {
			// get next context via scheduler that have no its own Executor service
			currentContext = scheduler.nextContext
			LOGGER.debug("Current Context: [{}]", currentContext)
//				var executor = currentContext.get(IMaiaExecutorService)
//				// find context without it's own executor 
//				while (executor != null) {
//
//					// TODO: fix possible infinite loop
//					currentContext = scheduler.nextContext
//					executor = currentContext.get(IMaiaExecutorService)
//				}
			action = currentContext.get(IMaiaContextAction)
			LOGGER.debug("	current action [{}]", action)
//			}
		}
		if (action != null) {
			action.beforeRun
			action.run
			action.afterRun
		}
	}
}