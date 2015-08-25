package ru.agentlab.maia.execution.tree

interface IExecutionNode {

	def void run()

	def IDataParameter getInput(String name)

	def void addInput(IDataParameter input)

	def void removeInput(IDataParameter input)

	def IDataParameter getOutput(String name)

	def void addOutput(IDataParameter output)

	def void removeOutput(IDataParameter output)
	
	def IExecutionScheduler getParent()
	
	def ExecutionNodeState getState()

}