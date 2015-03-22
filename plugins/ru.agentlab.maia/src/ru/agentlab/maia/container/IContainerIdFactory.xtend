package ru.agentlab.maia.container

import ru.agentlab.maia.platform.IPlatformId

interface IContainerIdFactory {

	def IContainerId create(IPlatformId platformId, String name, String address)
}