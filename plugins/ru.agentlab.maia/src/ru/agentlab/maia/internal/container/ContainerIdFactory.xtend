package ru.agentlab.maia.internal.container

import ru.agentlab.maia.container.IContainerIdFactory
import ru.agentlab.maia.platform.IPlatformId

class ContainerIdFactory implements IContainerIdFactory{
	
	override create(IPlatformId platformId, String name, String address) {
		return new ContainerId => [
//			platformId.containerIds += it
//			it.platformId = platformId
//			it.name = name
//			it.address = address
		]
	}
	
}