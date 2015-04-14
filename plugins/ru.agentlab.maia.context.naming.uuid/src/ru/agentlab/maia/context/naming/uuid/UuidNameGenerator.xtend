package ru.agentlab.maia.context.naming.uuid

import java.util.UUID
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory

class UuidNameGenerator implements IMaiaContextNameFactory {

	override createName() {
		return UUID.randomUUID.toString
	}

}