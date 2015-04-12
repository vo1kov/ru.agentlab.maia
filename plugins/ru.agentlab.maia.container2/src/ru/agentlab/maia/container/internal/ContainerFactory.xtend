package ru.agentlab.maia.container.internal

import java.util.UUID
import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.IMaiaContext
import ru.agentlab.maia.IMaiaContextFactory
import ru.agentlab.maia.IMaiaContextServiceManager
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.lifecycle.ILifecycleServiceFactory
import ru.agentlab.maia.naming.IMaiaContextNameFactory
import ru.agentlab.maia.initializer.IMaiaContextInitializerService

class ContainerFactory implements IContainerFactory {

	val static LOGGER = LoggerFactory.getLogger(ContainerFactory)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextFactory contextFactory

//	@Inject
//	IMaiaContextNameFactory contextNameFactory
	@Inject
	IMaiaContextServiceManager contextServiceManager

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

		contextServiceManager => [
			LOGGER.debug("	add lifecycle service...")
			getService(context, ILifecycleServiceFactory) => [
				createLifecycle(container)
			]

			LOGGER.debug("	add initializer service...")
			getService(container, IMaiaContextInitializerService)
		]

		LOGGER.info("Container successfully created!")
		return container
	}

}