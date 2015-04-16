package ru.agentlab.maia.launcher.task

import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.annotated.Action

class ContextDumpTask {

	val static LOGGER = LoggerFactory.getLogger(ContextDumpTask)

	@Inject
	IMaiaContext context

	@Action
	def void action() {
		println(context)
		LOGGER.info(context.dump)
	}

}