package ru.agentlab.maia.container

import ru.agentlab.maia.platform.IPlatform

interface IContainerNameGenerator {
	
	def String generateName(IPlatform platform)
	
}