package ru.agentlab.maia.behaviour

import ru.agentlab.maia.context.IMaiaContext

interface IBehaviourFactory {

	def IMaiaContext createBehaviour(IMaiaContext parentContext)

}