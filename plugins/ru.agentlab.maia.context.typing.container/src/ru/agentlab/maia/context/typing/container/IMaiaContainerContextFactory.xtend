package ru.agentlab.maia.context.typing.container

import ru.agentlab.maia.context.IMaiaContext

interface IMaiaContainerContextFactory {
	
	val static String TYPE = "container"

	def IMaiaContext createContainer()

}
