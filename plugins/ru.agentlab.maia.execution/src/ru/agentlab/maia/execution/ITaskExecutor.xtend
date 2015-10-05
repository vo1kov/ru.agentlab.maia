package ru.agentlab.maia.execution

interface ITaskExecutor {
	
	def void start()
	
	def void stop()
	
	def boolean isActive()
	
}