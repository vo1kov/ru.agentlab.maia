package ru.agentlab.maia.execution.scheduler.fsm

import ru.agentlab.maia.execution.IExecutionNode

interface IFsmTransition {

	def IExecutionNode getFrom()

	def IExecutionNode getTo()
}