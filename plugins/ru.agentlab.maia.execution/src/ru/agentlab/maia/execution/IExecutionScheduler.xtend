package ru.agentlab.maia.execution

interface IExecutionScheduler extends IExecutionNode {

	def IExecutionNode getNode()

	def Iterable<IExecutionNode> getChilds()

	def void addChild(IExecutionNode node)

	def boolean removeChild(IExecutionNode node)

	def void removeAll()

	def void notifyChildReady(IExecutionNode node)
	
	def void notifyChildBlocked()

	def void notifyChildSuccess()

	def void notifyChildException()
	
}