package ru.agentlab.maia.task.fsm

import ru.agentlab.maia.task.ITask

interface IFsmTransition {

	def ITask getFrom()

	def ITask getTo()
}