package ru.agentlab.maia.internal.platform

import ru.agentlab.maia.platform.IPlatformIdFactory

class PlatformIdFactory implements IPlatformIdFactory {

	override create(String name) {
		return new PlatformId => [
			it.name = name
		]
	}

}