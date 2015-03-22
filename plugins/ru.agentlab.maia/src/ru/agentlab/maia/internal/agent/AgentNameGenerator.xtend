package ru.agentlab.maia.internal.agent

import ru.agentlab.maia.agent.IAgentNameGenerator
import ru.agentlab.maia.container.IContainer

class AgentNameGenerator implements IAgentNameGenerator {

	override generateName(IContainer container) {
		// TODO: make sure that name unique
		val count = container.childs.size + 1
		return "Agent_" + count
	}

}