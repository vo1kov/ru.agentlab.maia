package ru.agentlab.maia.container

import java.util.UUID
import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.service.Create
import ru.agentlab.maia.context.service.IMaiaContextServiceManager

class ContainerFactory implements IContainerFactory {

	val static LOGGER = LoggerFactory.getLogger(ContainerFactory)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextFactory contextFactory

	@Inject
	IMaiaContextServiceManager contextServiceManager

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

//		contextServiceManager => [
//			LOGGER.debug("	add lifecycle service...")
//			getService(context, ILifecycleServiceFactory) => [
//				createLifecycle(container)
//			]
//
//			LOGGER.debug("	add initializer service...")
//			getService(container, IMaiaContextInitializerService)
//		]
		LOGGER.info("Container successfully created!")
		return container
	}

}