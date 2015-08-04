package ru.agentlab.maia.execution

import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaExecutorAction
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler

class MaiaExecutorFixedRunnable implements IMaiaExecutorRunnable {

	val static LOGGER = LoggerFactory.getLogger(MaiaExecutorFixedRunnable)

	var IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	def IMaiaExecutorAction getAction(IMaiaExecutorScheduler scheduler) {
		LOGGER.debug("Current Node: [{}]", scheduler)
		val next = scheduler.nextContext
		if (next instanceof IMaiaExecutorAction) {
			return next
		} else if (next instanceof IMaiaExecutorScheduler) {
			return getAction(next)
		}
	}

	override run() {
		val contextType = context.get(IMaiaContext.KEY_TYPE) as String
		Thread.currentThread.name = contextType + ": " + context.uuid
		try {
			LOGGER.debug("Start execution loop...")
			var action = context.get(IMaiaExecutorAction)
			if (action == null) {
				val scheduler = context.get(IMaiaExecutorScheduler)
				if (scheduler != null) {
					action = scheduler.getAction
				}
			}
			action => [
				if (it != null) {
					beforeRun
					run
					afterRun
				}
			]
			Thread.sleep(2000)
		} catch (Exception e) {
			LOGGER.error("Some exception", e)
		}
	}
}