package ru.agentlab.maia.internal.platform

import java.util.UUID
import ru.agentlab.maia.platform.IPlatformNameGenerator

class PlatformNameGenerator implements IPlatformNameGenerator {

	override String generate() {
		return UUID.randomUUID.toString
	}

}