package ru.agentlab.maia.execution

interface IExecutionScheduler extends IExecutionNode {

	def IExecutionNode getCurrent()

	def IExecutionNode setCurrent(IExecutionNode node)

	def Iterable<IExecutionNode> schedule()

	def Iterable<IExecutionNode> getChilds()

	def void addChild(IExecutionNode node)

	def boolean removeChild(IExecutionNode node)

	def void removeAll()

	def void markChildReady(IExecutionNode node)
	
	def void markChildInWork(IExecutionNode node)

	def void markChildWaiting(IExecutionNode node)

	def void markChildFinished(IExecutionNode node)

	def void markChildException(IExecutionNode node)
	
}