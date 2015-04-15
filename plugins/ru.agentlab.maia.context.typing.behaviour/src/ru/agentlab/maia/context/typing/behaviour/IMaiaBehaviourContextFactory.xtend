package ru.agentlab.maia.context.typing.behaviour

import ru.agentlab.maia.context.IMaiaContext

interface IMaiaBehaviourContextFactory {

	def IMaiaContext createBehaviour(IMaiaContext parentContext)

}