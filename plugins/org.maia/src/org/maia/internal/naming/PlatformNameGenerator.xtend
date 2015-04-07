package org.maia.internal.naming

import java.util.UUID
import org.maia.naming.IPlatformNameGenerator

class PlatformNameGenerator implements IPlatformNameGenerator {

	override String generate() {
		return UUID.randomUUID.toString
	}

}