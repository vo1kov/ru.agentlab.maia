package ru.agentlab.maia.execution

interface IExecutionAction extends IExecutionNode {

	def Object getImplementation()

	def void setImplementation(Object impl)
	
	def void run()

}