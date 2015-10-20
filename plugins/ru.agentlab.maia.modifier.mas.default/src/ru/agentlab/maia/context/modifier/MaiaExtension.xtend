package ru.agentlab.maia.context.modifier

import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.IInjector
import ru.agentlab.maia.context.hashmap.HashMapContext

class MaiaExtension {

	def <T> T deploy(IContext context, Class<T> serviceClass) {
		context.getService(IInjector).deploy(serviceClass)
	}

	def Object deploy(IContext context, Object service) {
		context.getService(IInjector).deploy(service)
	}

	def <T> T deploy(IContext context, T service, Class<T> interf) {
		context.getService(IInjector).deploy(service, interf)
	}

	def IContext createContainer(IContext parent) {
		return new HashMapContext => [
			it.parent = parent
			getService(IInjector).deploy(MaiaContainerContextModifier)
		]
	}

	def IContext createAgent(IContext parent) {
		return new HashMapContext => [
			it.parent = parent
			getService(IInjector).deploy(MaiaAgentContextModifier)
		]
	}

	def IContext createBehaviour(IContext parent) {
		return new HashMapContext => [
			it.parent = parent
			getService(IInjector).deploy(MaiaBehaviourContextModifier)
		]
	}

}