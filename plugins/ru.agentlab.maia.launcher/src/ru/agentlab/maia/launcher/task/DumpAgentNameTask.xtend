package ru.agentlab.maia.launcher.task

import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.Action
import ru.agentlab.maia.agent.IAgentId

class DumpAgentNameTask {

	val static LOGGER = LoggerFactory.getLogger(DumpAgentNameTask)

	@Inject
	IAgentId agentId

	@Action
	def void action() {
		LOGGER.info("Agent name [{}]", agentId.name)
	}
}