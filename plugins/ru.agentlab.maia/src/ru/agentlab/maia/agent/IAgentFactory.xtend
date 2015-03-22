package ru.agentlab.maia.agent

import ru.agentlab.maia.container.IContainer

interface IAgentFactory {

	def IAgent create(IContainer container, String id, Class<?> contributorClass)

}