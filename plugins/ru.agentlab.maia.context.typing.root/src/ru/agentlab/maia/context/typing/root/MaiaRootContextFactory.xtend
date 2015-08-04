package ru.agentlab.maia.context.typing.root

import javax.annotation.PostConstruct
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.context.typing.agent.MaiaAgentProfile
import ru.agentlab.maia.context.typing.behaviour.MaiaBehaviourProfile
import ru.agentlab.maia.context.typing.container.MaiaContainerProfile
import ru.agentlab.maia.context.typing.root.internal.Activator
import ru.agentlab.maia.event.IMaiaEventBroker

/**
 * Factory for creating Agent-Contexts
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class MaiaRootContextFactory {

	def createRootContext() {
		val contextFactory = Activator.getService(IMaiaContextFactory)
		val rootProfile = Activator.getService(MaiaRootContextProfile)
		val broker = Activator.getService(IMaiaEventBroker)
		val injector = Activator.getService(IMaiaContextInjector)
		val rootContext = contextFactory.createContext("root") => [
			set(IMaiaEventBroker, broker)
			set(IMaiaContextFactory, contextFactory)
			set(IMaiaContextInjector, injector)
			set(MaiaRootContextProfile, rootProfile)
			set(MaiaContainerProfile, Activator.getService(MaiaContainerProfile))
			set(MaiaAgentProfile, Activator.getService(MaiaAgentProfile))
			set(MaiaBehaviourProfile, Activator.getService(MaiaBehaviourProfile))
			set(IMaiaContext.KEY_TYPE, "root")

			rootProfile.implementationKeySet.forEach [ serviceInterface |
				val serviceClass = rootProfile.getImplementation(serviceInterface)
				if (serviceClass != null) {
					val serviceObj = injector.make(serviceClass, it)
					injector.invoke(serviceObj, PostConstruct, it, null)
					set(serviceInterface.name, serviceObj)
				}
			]

		]

		return rootContext
	}

}
