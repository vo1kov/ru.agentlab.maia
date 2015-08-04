package ru.agentlab.maia.context.typing.behaviour

import ru.agentlab.maia.context.IMaiaContext

interface IMaiaBehaviourContextFactory {
	
	val static String TYPE = "behaviour"

	def IMaiaContext createBehaviour()

}