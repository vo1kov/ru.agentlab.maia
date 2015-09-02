package ru.agentlab.maia.execution.scheduler.fsm

import ru.agentlab.maia.execution.tree.IExecutionNode

interface IFsmTransition {
	
	def IExecutionNode getFrom()

	def IExecutionNode getTo()
}