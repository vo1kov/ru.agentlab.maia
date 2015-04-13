package ru.agentlab.maia.naming.uuid

import java.util.UUID
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory

class UuidNameGenerator implements IMaiaContextNameFactory {

	override createName() {
		return UUID.randomUUID.toString
	}

}