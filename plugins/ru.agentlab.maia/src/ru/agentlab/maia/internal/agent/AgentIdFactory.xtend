package ru.agentlab.maia.internal.agent

import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentIdFactory
import ru.agentlab.maia.container.IContainerId

class AgentIdFactory implements IAgentIdFactory {

	val static LOGGER = LoggerFactory.getLogger(AgentIdFactory)

	override create(IContainerId containerId, String name) {
		LOGGER.info("Create AgentId for [{}] containerId, [{}] name", containerId, name)
		return new AgentId => [
			it.containerId = containerId
			containerId.agentIds += it
			it.name = name
		]
	}

}