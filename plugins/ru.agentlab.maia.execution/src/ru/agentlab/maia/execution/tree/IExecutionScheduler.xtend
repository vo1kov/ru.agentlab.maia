package ru.agentlab.maia.execution.tree

import java.util.List

interface IExecutionScheduler extends IExecutionNode {

	def IExecutionNode getCurrent()

	def void setCurrent(IExecutionNode node)

	def IExecutionNode schedule() throws IllegalSchedulerStateException

	def List<IDataLink> getDataLinks()

	def List<IExecutionNode> getChilds()

	def void addChild(IExecutionNode node)

//	def void notifyChildActivation(IExecutionNode node)
//
//	def void notifyChildDeactivation(IExecutionNode node)

	def IExecutionNode removeChild(IExecutionNode node)

	def void removeAll()

	def boolean isEmpty()
	
	def void handleChildUnknown(IExecutionNode child)
	
	def void handleChildReady(IExecutionNode child)
	
	def void handleChildInWork(IExecutionNode child)
	
	def void handleChildWait(IExecutionNode child)
	
	def void handleChildFinish(IExecutionNode child)

}