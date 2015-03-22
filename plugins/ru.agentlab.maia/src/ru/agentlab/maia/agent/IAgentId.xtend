package ru.agentlab.maia.agent

import java.util.List
import ru.agentlab.maia.container.IContainerId

interface IAgentId {

	def IContainerId getContainerId()

	def void setContainerId(IContainerId containerId)

	def String getName()

	def void setName(String name)

	def List<String> getAddresses()

	def List<IAgentId> getResolvers()

}