package ru.agentlab.maia.agent

import ru.agentlab.maia.IAgent
import ru.agentlab.maia.IAgentId
import ru.agentlab.maia.IContainerId
import org.osgi.framework.Bundle

interface IAgentLifecycleService {

	def IAgent bornAgent(String id, IContainerId container, Bundle bundle, String className)

	def void pauseAgent(IAgentId agent)

	def void stopAgent(IAgentId agent)

	def void resumeAgent(IAgentId agent)

	def void killAgent(IAgentId agent)

}