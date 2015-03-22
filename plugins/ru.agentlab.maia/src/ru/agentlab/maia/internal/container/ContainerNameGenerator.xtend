package ru.agentlab.maia.internal.container

import ru.agentlab.maia.container.IContainerNameGenerator
import ru.agentlab.maia.platform.IPlatform

class ContainerNameGenerator implements IContainerNameGenerator {

	override generateName(IPlatform platform) {
		// TODO: make sure that name unique
		val count = platform.childs.size + 1
		return "Container" + count
	}

}