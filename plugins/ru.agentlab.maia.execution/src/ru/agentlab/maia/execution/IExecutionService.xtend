package ru.agentlab.maia.execution

interface IExecutionService {
	
	def void start()
	
	def void stop()
	
	def void submit(IExecutionNode node)
	
	def boolean isActive()
	
}