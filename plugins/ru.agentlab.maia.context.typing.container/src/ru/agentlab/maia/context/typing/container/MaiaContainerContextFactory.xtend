package ru.agentlab.maia.context.typing.container

import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.service.Create
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService
import ru.agentlab.maia.context.typing.IMaiaContextTyping

/**
 * Factory for creating Container contexts
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class MaiaContainerContextFactory implements IMaiaContainerContextFactory {

	val static LOGGER = LoggerFactory.getLogger(MaiaContainerContextFactory)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextFactory contextFactory

	@Inject
	IMaiaContextServiceManagementService contextServiceManagementService

	@Inject
	MaiaContainerProfile containerProfile

	@Create
	override createContainer(IMaiaContext parentContext) {
		val context = if (parentContext != null) {
				parentContext
			} else {
				this.context
			}
		LOGGER.info("Create new Container...")
		LOGGER.debug("	home context: [{}]", context)

		LOGGER.info("Create Container Name...")
		val namingService = context.get(IMaiaContextNameFactory)
		if (namingService == null) {
			throw new IllegalStateException("Agent Profile have no required IMaiaContextNameFactory")
		}
		val name = namingService.createName
		LOGGER.debug("	generated name: [{}]", name)

		LOGGER.info("Create Container Context...")
		val containerContext = contextFactory.createChild(context, "MAIA Container context: " + name) => [
			set(IMaiaContextNameFactory.KEY_NAME, name)
			set(IMaiaContextTyping.KEY_TYPE, "container")
		]

		LOGGER.info("Create Container specific services...")
		contextServiceManagementService => [ manager |
			containerProfile.implementationKeySet.forEach [
				manager.createService(containerProfile, containerContext, it)
			]
			containerProfile.factoryKeySet.forEach [
				manager.createServiceFromFactory(containerProfile, context, containerContext, it)
			]
		]
		LOGGER.info("Container successfully created!")
		return containerContext
	}

}