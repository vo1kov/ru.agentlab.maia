package ru.agentlab.maia.internal.naming

import java.util.UUID
import ru.agentlab.maia.naming.IAgentNameGenerator
import ru.agentlab.maia.naming.IBehaviourNameGenerator
import ru.agentlab.maia.naming.IContainerNameGenerator
import ru.agentlab.maia.naming.IPlatformNameGenerator

class UuidNameGenerator implements IPlatformNameGenerator, IContainerNameGenerator, IAgentNameGenerator, IBehaviourNameGenerator {

	override String generate() {
		return UUID.randomUUID.toString
	}

}