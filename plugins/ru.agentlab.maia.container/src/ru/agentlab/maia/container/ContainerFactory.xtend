package ru.agentlab.maia.container

import java.util.UUID
import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.service.Create
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService

class ContainerFactory implements IContainerFactory {

	val static LOGGER = LoggerFactory.getLogger(ContainerFactory)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextFactory contextFactory

	@Inject
	IMaiaContextServiceManagementService contextServiceManager
	
	@Inject
	MaiaContainerProfile agentProfile

	@Create
	override createContainer(IMaiaContext parent) {
		val context = if (parent != null) {
				parent
			} else {
				this.context
			}
		LOGGER.info("Try to create new Default Container...")
		LOGGER.debug("	home context: [{}]", context)

		LOGGER.info("Generate Container Name...")
		val name = UUID.randomUUID.toString // contextNameFactory.createName
		LOGGER.debug("	generated name: [{}]", name)

		LOGGER.info("Create Container Context...")
		val container = contextFactory.createChild(context, "Context for Container: " + name) => [
			set(IMaiaContextNameFactory.KEY_NAME, name)
		]
		
		LOGGER.info("Create Container specific services...")
		contextServiceManager => [ manager | 
			agentProfile.implementationKeySet.forEach [
				manager.createService(agentProfile, container, it)
			]
			agentProfile.factoryKeySet.forEach [
				manager.createServiceFromFactory(agentProfile, context, container, it)
			]
		]
		LOGGER.info("Container successfully created!")
		return container
	}

}