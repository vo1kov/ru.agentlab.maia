package ru.agentlab.maia.context.behaviour

import ru.agentlab.maia.context.IMaiaContext

interface IMaiaContextBehaviourFactory {

	def IMaiaContext createBehaviour(IMaiaContext parentContext)

}