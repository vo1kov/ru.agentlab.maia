package ru.agentlab.maia.task

interface ITaskExecutor {
	
	def void start()
	
	def void stop()
	
	def boolean isActive()
	
}