package ru.agentlab.maia.agent

import ru.agentlab.maia.container.IContainerId

interface IAgentIdFactory {

	def IAgentId create(IContainerId containerId, String name)
	
}