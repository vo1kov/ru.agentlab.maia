package ru.agentlab.maia.execution.scheduler.fsm

import ru.agentlab.maia.execution.ITask

interface IFsmTransition {

	def ITask getFrom()

	def ITask getTo()
}