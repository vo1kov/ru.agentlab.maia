package ru.agentlab.maia.launcher.task

import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.execution.action.annotated.Action
import ru.agentlab.maia.context.IContext

class ContextDumpTask {

	val static LOGGER = LoggerFactory.getLogger(ContextDumpTask)

	@Inject
	IContext context

	@Action
	def void action() {
		println(context)
		LOGGER.info(context.dump)
	}

}