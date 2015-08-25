package ru.agentlab.maia.execution.tree

interface IExecutionScheduler extends IExecutionNode {

	val static public String KEY_CURRENT_CONTEXT = "ru.agentlab.maia.execution.scheduler|current.context"

	def IExecutionNode getCurrentChild()

	def IExecutionNode getNextChild()

	def Iterable<IDataLink> getDataLinks()

	def Iterable<IExecutionNode> getChilds()

	def void addChild(IExecutionNode node)

	def void notifyChildActivation(IExecutionNode node)

	def void notifyChildDeactivation(IExecutionNode node)

	def void removeChild(IExecutionNode node)

	def void removeAll()

	def boolean isEmpty()

}