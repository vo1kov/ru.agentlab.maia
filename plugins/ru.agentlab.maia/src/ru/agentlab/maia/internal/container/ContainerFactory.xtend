package ru.agentlab.maia.internal.container

import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.container.IContainerId
import ru.agentlab.maia.container.IContainerIdFactory
import ru.agentlab.maia.internal.MaiaActivator
import ru.agentlab.maia.naming.IContainerNameGenerator
import ru.agentlab.maia.platform.IPlatformId

class ContainerFactory implements IContainerFactory {

	val static LOGGER = LoggerFactory.getLogger(ContainerFactory)

	override createDefault(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Container...")
		LOGGER.debug("	Container Id: [{}]", id)

		val context = createEmpty(root, id)
		val name = context.get(KEY_NAME) as String

		LOGGER.info("Prepare ContainerID in Context...")
		val containerIdFactory = context.get(IContainerIdFactory)
		val platformId = context.get(IPlatformId)
		val containerId = containerIdFactory.create(platformId, name, null)
		context.set(IContainerId, containerId)

		return context
	}

	override createEmpty(IEclipseContext root, String id) {
		LOGGER.info("Try to create new empty Container...")
		LOGGER.debug("	Container Id: [{}]", id)

		LOGGER.info("Prepare Container root context...")
		val rootContext = if (root != null) {
				root
			} else {
				LOGGER.info("Root context is null, get it from OSGI services...")
				MaiaActivator.osgiContext
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
		val context = rootContext.createChild("Container [" + name + "] Context") => [
			addContextProperty(KEY_NAME, name)
			addContextProperty(KEY_TYPE, "ru.agentlab.maia.container")
		]

		LOGGER.info("Empty Container successfully created!")
		return context
	}

	def private void addContextProperty(IEclipseContext context, String key, Object value) {
		LOGGER.debug("	Put Property [{}] with vale [{}]  to context...", key, value)
		context.set(key, value)
	}

}