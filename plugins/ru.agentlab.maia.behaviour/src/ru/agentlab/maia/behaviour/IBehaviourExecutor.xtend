package ru.agentlab.maia.behaviour

interface IBehaviourExecutor {
	
	def void start()
	
	def void stop()
	
	def boolean isActive()
	
}