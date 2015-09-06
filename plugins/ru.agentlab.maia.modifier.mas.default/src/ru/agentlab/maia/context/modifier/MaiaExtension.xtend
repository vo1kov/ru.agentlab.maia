package ru.agentlab.maia.context.modifier

import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextFactory
import ru.agentlab.maia.memory.IMaiaServiceDeployer

class MaiaExtension {

	def <T> T deploy(IMaiaContext context, Class<T> serviceClass) {
		context.get(IMaiaServiceDeployer).deploy(serviceClass)
	}

	def Object deploy(IMaiaContext context, Object service) {
		context.get(IMaiaServiceDeployer).deploy(service)
	}

	def <T> T deploy(IMaiaContext context, T service, Class<T> interf) {
		context.get(IMaiaServiceDeployer).deploy(service, interf)
	}

	def IMaiaContext createContainer(IMaiaContext parent) {
		return parent.get(IMaiaContextFactory).createContext => [
			get(IMaiaServiceDeployer).deploy(MaiaContainerContextModifier)
		]
	}

	def IMaiaContext createAgent(IMaiaContext parent) {
		return parent.get(IMaiaContextFactory).createContext => [
			get(IMaiaServiceDeployer).deploy(MaiaAgentContextModifier)
		]
	}

	def IMaiaContext createBehaviour(IMaiaContext parent) {
		return parent.get(IMaiaContextFactory).createContext => [
			get(IMaiaServiceDeployer).deploy(MaiaBehaviourContextModifier)
		]
	}

}