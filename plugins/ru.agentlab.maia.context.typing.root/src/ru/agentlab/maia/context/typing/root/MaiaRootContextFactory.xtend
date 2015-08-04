package ru.agentlab.maia.context.typing.root

import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.injector.IMaiaContextInjector
import ru.agentlab.maia.context.service.Create
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService
import ru.agentlab.maia.context.typing.IMaiaContextTyping
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

	val static LOGGER = LoggerFactory.getLogger(MaiaRootContextFactory)

	@Create
	def createRootContext() {
		LOGGER.info("Create new Root context...")
		val contextFactory = Activator.getService(IMaiaContextFactory)
		val rootProfile = Activator.getService(MaiaRootContextProfile)
		val contextServiceManagementService = Activator.getService(IMaiaContextServiceManagementService)
		val broker = Activator.getService(IMaiaEventBroker)
		val rootContext = contextFactory.createContext("root") => [
			set(IMaiaEventBroker, broker)
			set(IMaiaContextFactory, contextFactory)
			set(IMaiaContextInjector, Activator.getService(IMaiaContextInjector))
			set(IMaiaContextServiceManagementService, contextServiceManagementService)

			set(MaiaRootContextProfile, rootProfile)
			set(MaiaContainerProfile, Activator.getService(MaiaContainerProfile))
			set(MaiaAgentProfile, Activator.getService(MaiaAgentProfile))
			set(MaiaBehaviourProfile, Activator.getService(MaiaBehaviourProfile))
			set(IMaiaContextTyping.KEY_TYPE, "root")
		]

		LOGGER.info("Create Root context specific services...")
		contextServiceManagementService => [ manager |
			rootProfile.implementationKeySet.forEach [
				manager.createService(rootProfile, rootContext, it)
			]
			rootProfile.factoryKeySet.forEach [
				manager.createServiceFromFactory(rootProfile, rootContext, rootContext, it)
			]
		]

		LOGGER.info("Root context successfully created!")
		return rootContext
	}

}
