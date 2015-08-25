package ru.agentlab.maia.execution.tree

import java.util.List

interface IExecutionScheduler extends IExecutionNode {
	
	val static public String KEY_CURRENT_CONTEXT = "ru.agentlab.maia.execution.scheduler|current.context"
	
	def IExecutionNode getCurrent()
	
	def IExecutionNode getNext()
	
	def List<IDataLink> getLinks()
	
	def List<IExecutionNode> getChilds()
	
	def void remove(IExecutionNode node)

	def void removeAll()

	def boolean isEmpty()

	def void add(IExecutionNode node)

}