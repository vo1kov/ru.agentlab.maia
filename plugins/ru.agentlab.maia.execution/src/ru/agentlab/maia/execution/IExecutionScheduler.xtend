package ru.agentlab.maia.execution

interface IExecutionScheduler extends IExecutionNode {

	def IExecutionNode getCurrent()

	def IExecutionNode setCurrent(IExecutionNode node)

	def IExecutionNode schedule()

	def Iterable<IExecutionNode> getChilds()

	def void addChild(IExecutionNode node)

	def boolean removeChild(IExecutionNode node)

	def void removeAll()

}