package ru.agentlab.maia.internal.container

import java.util.ArrayList
import java.util.List
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.container.IContainerId
import ru.agentlab.maia.container.IContainerIdFactory
import ru.agentlab.maia.context.ContextExtension
import ru.agentlab.maia.internal.MaiaActivator
import ru.agentlab.maia.naming.IContainerNameGenerator
import ru.agentlab.maia.platform.IPlatformId

class ContainerFactory implements IContainerFactory {

	val static LOGGER = LoggerFactory.getLogger(ContainerFactory)

	extension ContextExtension = new ContextExtension(LOGGER)

	override createDefault(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Default Container...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	container Id: [{}]", id)

		val context = internalCreateEmpty(root, id)
		val name = context.get(KEY_NAME) as String

		LOGGER.info("Create Container ID...")
		val containerIdFactory = context.get(IContainerIdFactory)
		val platformId = context.get(IPlatformId)
		val containerId = containerIdFactory.create(platformId, name, null)
		context.set(IContainerId, containerId)

		LOGGER.info("Container successfully created!")
		return context
	}

	override createEmpty(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Empty Container...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	container Id: [{}]", id)

		val context = internalCreateEmpty(root, id)

		LOGGER.info("Container successfully created!")
		return context
	}

	private def internalCreateEmpty(IEclipseContext root, String id) {
		val rootContext = if (root != null) {
				root
			} else {
				LOGGER.warn("Root context is null, get it from OSGI services...")
				EclipseContextFactory.getServiceContext(MaiaActivator.context)
			}

		val name = if (id != null) {
				id
			} else {
				LOGGER.info("Generate Container Name...")
				val nameGenerator = rootContext.get(IContainerNameGenerator)
				val n = nameGenerator.generate(rootContext)
				LOGGER.debug("	Container Name is [{}]", n)
				n
			}

		LOGGER.info("Create Container Context...")
		val context = rootContext.createChild("Context for Container: " + name) => [
			declareModifiable(KEY_AGENTS)
			addContextProperty(KEY_NAME, name)
			addContextProperty(KEY_TYPE, TYPE_CONTAINER)
		]
		
		LOGGER.info("Add link for parent Context...")
		var containers = rootContext.get(KEY_CONTAINERS) as List<IEclipseContext>
		if (containers == null) {
			LOGGER.debug("	Parent Context [{}] have no containers link, create new list...", rootContext)
			containers = new ArrayList<IEclipseContext>
			rootContext.set(KEY_CONTAINERS, containers)
		}
		containers += context
		context
	}

}