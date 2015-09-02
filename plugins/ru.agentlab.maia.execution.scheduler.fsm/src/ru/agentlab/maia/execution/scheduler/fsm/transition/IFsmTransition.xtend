package ru.agentlab.maia.execution.scheduler.fsm.transition

import ru.agentlab.maia.execution.tree.IExecutionNode

interface IFsmTransition {
	
	def String getName()

	def IExecutionNode getFrom()

	def IExecutionNode getTo()
}