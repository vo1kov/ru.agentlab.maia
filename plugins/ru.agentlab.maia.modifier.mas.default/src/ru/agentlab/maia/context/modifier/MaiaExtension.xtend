package ru.agentlab.maia.context.modifier

import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextFactory
import ru.agentlab.maia.memory.IMaiaContextInjector

class MaiaExtension {

	def <T> T deploy(IMaiaContext context, Class<T> serviceClass) {
		context.get(IMaiaContextInjector).deploy(serviceClass)
	}

	def Object deploy(IMaiaContext context, Object service) {
		context.get(IMaiaContextInjector).deploy(service)
	}

	def <T> T deploy(IMaiaContext context, T service, Class<T> interf) {
		context.get(IMaiaContextInjector).deploy(service, interf)
	}

	def IMaiaContext createContainer(IMaiaContext parent) {
		return parent.get(IMaiaContextFactory).createContext => [
			get(IMaiaContextInjector).deploy(MaiaContainerContextModifier)
		]
	}

	def IMaiaContext createAgent(IMaiaContext parent) {
		return parent.get(IMaiaContextFactory).createContext => [
			get(IMaiaContextInjector).deploy(MaiaAgentContextModifier)
		]
	}

	def IMaiaContext createBehaviour(IMaiaContext parent) {
		return parent.get(IMaiaContextFactory).createContext => [
			get(IMaiaContextInjector).deploy(MaiaBehaviourContextModifier)
		]
	}

}