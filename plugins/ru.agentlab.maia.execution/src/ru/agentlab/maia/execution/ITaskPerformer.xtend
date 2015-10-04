package ru.agentlab.maia.execution

interface ITaskPerformer {
	
	def void start()
	
	def void stop()
	
	def boolean isActive()
	
}