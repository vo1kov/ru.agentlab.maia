package ru.agentlab.maia.agent

interface IAgentFactory {
	
	def IAgent create(String id, Class<?> contributor)
	
}