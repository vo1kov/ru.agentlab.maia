package ru.agentlab.maia.behaviour

import ru.agentlab.maia.agent.IAgent

interface IBehaviourFactory {
	
	def IBehaviour create(IAgent agent, String id, Class<?> contributorClass)
}