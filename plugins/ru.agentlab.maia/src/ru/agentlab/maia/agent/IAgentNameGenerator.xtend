package ru.agentlab.maia.agent

import ru.agentlab.maia.container.IContainer

interface IAgentNameGenerator {

	def String generateName(IContainer container)
		
}