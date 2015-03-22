package ru.agentlab.maia.container

import java.util.List
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.platform.IPlatform

interface IContainer {

	val static String KEY_STATE = "container.state"

	val static String KEY_NAME = "container.name"

	val static String KEY_CONTRIBUTOR = "container.contributor"

	def List<IAgent> getAgents()

	def IPlatform getPlatform()

	def IContainerId getContainerId()

	def void setContainerId(IContainerId containerId)

}