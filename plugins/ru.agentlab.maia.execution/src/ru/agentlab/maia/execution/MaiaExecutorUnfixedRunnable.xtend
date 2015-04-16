package ru.agentlab.maia.execution

import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.typing.IMaiaContextTyping
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler

class MaiaExecutorUnfixedRunnable implements IMaiaExecutorRunnable {

	val static LOGGER = LoggerFactory.getLogger(MaiaExecutorFixedRunnable)

	var IMaiaContext context

	val Object lock = new Object

	new(IMaiaContext context) {
		this.context = context
	}

	def IMaiaContextAction getAction(IMaiaExecutorScheduler scheduler) {
		LOGGER.debug("Current Node: [{}]", scheduler)
		val next = scheduler.nextContext
		if (next instanceof IMaiaContextAction) {
			return next
		} else if (next instanceof IMaiaExecutorScheduler) {
			return getAction(next)
		}
	}

	override run() {
		val contextType = context.get(IMaiaContextTyping.KEY_TYPE) as String
		val contextName = context.get(IMaiaContextNameFactory.KEY_NAME) as String
		Thread.currentThread.name = contextType + ": " + contextName

		while (true) {
			try {
				LOGGER.debug("Start execution loop...")
				var action = context.get(IMaiaContextAction)
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

}