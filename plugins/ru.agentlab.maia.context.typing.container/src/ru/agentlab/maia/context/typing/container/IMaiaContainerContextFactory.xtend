package ru.agentlab.maia.context.typing.container

import ru.agentlab.maia.context.IMaiaContext

interface IMaiaContainerContextFactory {

	def IMaiaContext createContainer(IMaiaContext parentContext)

}
