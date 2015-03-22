package ru.agentlab.maia.container

import ru.agentlab.maia.platform.IPlatform

interface IContainerFactory {

	def IContainer create(IPlatform platform, String id, Class<?> contributorClass)

}