package ru.agentlab.maia.internal.naming

import java.util.UUID
import ru.agentlab.maia.naming.IPlatformNameGenerator

class PlatformNameGenerator implements IPlatformNameGenerator {

	override String generate() {
		return UUID.randomUUID.toString
	}

}