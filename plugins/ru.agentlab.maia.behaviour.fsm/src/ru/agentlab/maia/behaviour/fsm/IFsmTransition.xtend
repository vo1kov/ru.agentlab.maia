package ru.agentlab.maia.behaviour.fsm

import ru.agentlab.maia.behaviour.IBehaviour

interface IFsmTransition {

	def IBehaviour getFrom()

	def IBehaviour getTo()
}