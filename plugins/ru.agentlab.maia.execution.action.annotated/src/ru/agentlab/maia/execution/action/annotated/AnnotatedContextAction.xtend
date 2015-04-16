package ru.agentlab.maia.execution.action.annotated

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.injector.IMaiaContextInjector
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler

class AnnotatedContextAction implements IMaiaContextAction {

	val static LOGGER = LoggerFactory.getLogger(AnnotatedContextAction)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	@PostConstruct
	def void init() {
		val parentScheduler = context.parent.get(IMaiaExecutorScheduler)
		if (parentScheduler != null) {
			LOGGER.info("Add node [{}] to scheduler [{}]...", this, parentScheduler)
			parentScheduler?.add(this)
		}
	}

	override beforeRun() {
	}

	override run() {
		val task = context.get(KEY_TASK)
		if (task != null) {
			return injector.invoke(task, Action, context)
		}
	}

	override afterRun() {
	}
	
}