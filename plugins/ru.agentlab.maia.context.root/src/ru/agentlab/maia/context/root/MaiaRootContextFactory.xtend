package ru.agentlab.maia.context.root

import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.MaiaAgentProfile
import ru.agentlab.maia.behaviour.MaiaBehaviourProfile
import ru.agentlab.maia.container.MaiaContainerProfile
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.root.internal.Activator
import ru.agentlab.maia.context.service.Create
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService

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
		val rootContext = contextFactory.createContext("Maia Root context") => [
			set(IMaiaContextFactory, contextFactory)
			set(IMaiaContextServiceManagementService, contextServiceManagementService)

			set(MaiaRootContextProfile, rootProfile)
			set(MaiaContainerProfile, Activator.getService(MaiaContainerProfile))
			set(MaiaAgentProfile, Activator.getService(MaiaAgentProfile))
			set(MaiaBehaviourProfile, Activator.getService(MaiaBehaviourProfile))
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
