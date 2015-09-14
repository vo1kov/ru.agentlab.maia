package ru.agentlab.maia.context.modifier

import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextInjector
import ru.agentlab.maia.memory.context.hashmap.HashMapContext

class MaiaExtension {

	def <T> T deploy(IMaiaContext context, Class<T> serviceClass) {
		context.getService(IMaiaContextInjector).deploy(serviceClass)
	}

	def Object deploy(IMaiaContext context, Object service) {
		context.getService(IMaiaContextInjector).deploy(service)
	}

	def <T> T deploy(IMaiaContext context, T service, Class<T> interf) {
		context.getService(IMaiaContextInjector).deploy(service, interf)
	}

	def IMaiaContext createContainer(IMaiaContext parent) {
		return new HashMapContext => [
			it.parent = parent
			getService(IMaiaContextInjector).deploy(MaiaContainerContextModifier)
		]
	}

	def IMaiaContext createAgent(IMaiaContext parent) {
		return new HashMapContext => [
			it.parent = parent
			getService(IMaiaContextInjector).deploy(MaiaAgentContextModifier)
		]
	}

	def IMaiaContext createBehaviour(IMaiaContext parent) {
		return new HashMapContext => [
			it.parent = parent
			getService(IMaiaContextInjector).deploy(MaiaBehaviourContextModifier)
		]
	}

}