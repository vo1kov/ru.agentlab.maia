package ru.agentlab.maia.launcher.task

import javax.inject.Inject
import javax.inject.Named
import org.maia.task.Action
import org.slf4j.LoggerFactory
import ru.agentlab.maia.naming.IMaiaContextNameFactory

class DumpAgentNameTask {

	val static LOGGER = LoggerFactory.getLogger(DumpAgentNameTask)

	@Inject @Named(IMaiaContextNameFactory.KEY_NAME)
	String agentName

	@Action
	def void action() {
		LOGGER.info("Agent name [{}]", agentName)
	}
}