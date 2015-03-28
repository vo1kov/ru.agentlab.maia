package ru.agentlab.maia.internal.naming

import java.util.UUID
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.naming.IPlatformNameGenerator

class PlatformNameGenerator implements IPlatformNameGenerator {

	override String generate(IEclipseContext context) {
		return UUID.randomUUID.toString
	}

}