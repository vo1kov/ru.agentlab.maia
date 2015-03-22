package ru.agentlab.maia.internal.agent

import ru.agentlab.maia.agent.IAgentNameGenerator
import java.util.UUID

class AgentNameGenerator implements IAgentNameGenerator {
	
	override generateName() {
		"Agent_" + UUID.randomUUID.toString
	}
	
}