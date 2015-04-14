package ru.agentlab.maia.context.container

import ru.agentlab.maia.context.IMaiaContext

interface IContainerFactory {

	def IMaiaContext createContainer(IMaiaContext parentContext)

}
