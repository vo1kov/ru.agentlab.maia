package ru.agentlab.maia.execution

import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaExecutorAction
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler

class MaiaExecutorUnfixedRunnable implements IMaiaExecutorRunnable {

	val static LOGGER = LoggerFactory.getLogger(MaiaExecutorFixedRunnable)

	var IMaiaContext context

	val Object lock = new Object

	new(IMaiaContext context) {
		this.context = context
	}

	def IMaiaExecutorAction getAction(IMaiaExecutorScheduler scheduler) {
		LOGGER.debug("Current scheduler: [{}]", scheduler)
		if (scheduler.isEmpty) {
			LOGGER.debug("	scheduler is empty")
			val parentScheduler = scheduler.parentNode as IMaiaExecutorScheduler
			if (parentScheduler != null) {
				parentScheduler.remove(scheduler)
				return parentScheduler.getAction
			} else {
				return null
			}
		} else {
			val next = scheduler.nextContext
			LOGGER.debug("	next node: [{}]", next)
			if (next instanceof IMaiaExecutorAction) {
				return next
			} else if (next instanceof IMaiaExecutorScheduler) {
				return next.getAction
			}
		}
	}

	override run() {
		val contextType = context.get(IMaiaContext.KEY_TYPE) as String
		Thread.currentThread.name = contextType + ": " + context.uuid

		while (true) {
			try {
				LOGGER.debug("Start execution loop...")
				var action = context.get(IMaiaExecutorAction)
				LOGGER.debug("	current action [{}]...", action)
				if (action == null) {
					val scheduler = context.get(IMaiaExecutorScheduler)
					LOGGER.debug("	current scheduler [{}]...", scheduler)
					if (scheduler != null) {
						action = scheduler.getAction
						if (action != null) {
							action.act
						} else {
							LOGGER.debug("Root scheduler is empty... Wait...")
							lock()
						}
					} else {
						LOGGER.debug("Root scheduler is empty... Wait...")
						lock()
					}
				} else {
					action.act
				}
				Thread.sleep(2000)
			} catch (Exception e) {
				LOGGER.error("Some exception", e)
			}
		}
	}

	def void lock() {
		synchronized (lock) {
			lock.wait
		}
	}

	def private void act(IMaiaExecutorAction action) {
		action.beforeRun
		action.run
		action.afterRun
	}

}