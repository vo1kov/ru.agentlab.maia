package ru.agentlab.maia.execution.tree

import java.util.Iterator

interface IExecutionScheduler extends IExecutionNode {

	def IExecutionNode getCurrent()

	def IExecutionNode setCurrent(IExecutionNode node)

	def IExecutionNode schedule() throws IllegalSchedulerStateException

	def Iterator<IExecutionNode> getChilds()

	def void addChild(IExecutionNode node)

	def boolean removeChild(IExecutionNode node)

	def void removeAll()

	def boolean isEmpty()

	def void handleChildChangedState(IExecutionNode child, int oldState, int newState)

}