package ru.agentlab.maia.behaviour.fsm

import ru.agentlab.maia.behaviour.execution.IExecutionStep

interface IFsmTransition {

	def IExecutionStep getFrom()

	def IExecutionStep getTo()
}
