package ru.agentlab.maia.execution.tree

import java.util.List

interface IExecutionScheduler extends IExecutionNode {

	val static public String KEY_CURRENT_CONTEXT = "ru.agentlab.maia.execution.scheduler|current.context"

	def IExecutionNode getCurrentChild()

	def void setCurrentChild(IExecutionNode node)

	def IExecutionNode getNextChild()

	def List<IDataLink> getDataLinks()

	def List<IExecutionNode> getChilds()

	def void addChild(IExecutionNode node)

	def void notifyChildActivation(IExecutionNode node)

	def void notifyChildDeactivation(IExecutionNode node)

	def IExecutionNode removeChild(IExecutionNode node)

	def void removeAll()

	def boolean isEmpty()

}