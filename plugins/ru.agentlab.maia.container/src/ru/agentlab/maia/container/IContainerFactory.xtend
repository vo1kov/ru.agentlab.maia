package ru.agentlab.maia.container

import ru.agentlab.maia.IMaiaContext

interface IContainerFactory {

	def IMaiaContext createContainer(IMaiaContext parent)

}
