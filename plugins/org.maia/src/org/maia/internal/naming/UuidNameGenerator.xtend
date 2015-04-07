package org.maia.internal.naming

import java.util.UUID
import org.maia.naming.IAgentNameGenerator
import org.maia.naming.IBehaviourNameGenerator
import org.maia.naming.IContainerNameGenerator
import org.maia.naming.IPlatformNameGenerator

class UuidNameGenerator implements IPlatformNameGenerator, IContainerNameGenerator, IAgentNameGenerator, IBehaviourNameGenerator {

	override String generate() {
		return UUID.randomUUID.toString
	}

}