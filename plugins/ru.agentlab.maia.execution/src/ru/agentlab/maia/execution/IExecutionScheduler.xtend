package ru.agentlab.maia.execution

import java.util.Iterator

interface IExecutionScheduler extends IExecutionNode {

	def IExecutionNode getCurrent()

	def IExecutionNode setCurrent(IExecutionNode node)

	def IExecutionNode schedule()

	def Iterator<IExecutionNode> getChilds()

	def void addChild(IExecutionNode node)

	def boolean removeChild(IExecutionNode node)

	def void removeAll()

	def boolean isEmpty()
	
//	def void onChildChangedState(IExecutionNode node, String oldState, String newState)

//	def void onChildUnknown(IExecutionNode node)
//
//	def void onChildReady(IExecutionNode node)
//
//	def void onChildInWork(IExecutionNode node)
//
//	def void onChildWaiting(IExecutionNode node)
//
//	def void onChildFinished(IExecutionNode node)
//
//	def void onChildException(IExecutionNode node)

}