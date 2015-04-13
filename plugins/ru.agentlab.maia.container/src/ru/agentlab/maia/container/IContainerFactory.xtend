package ru.agentlab.maia.container

import ru.agentlab.maia.context.IMaiaContext

interface IContainerFactory {

	def IMaiaContext createContainer(IMaiaContext parent)

}
