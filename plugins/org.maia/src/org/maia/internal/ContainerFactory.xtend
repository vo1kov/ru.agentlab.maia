package org.maia.internal

import java.util.ArrayList
import java.util.List
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.maia.IAgentFactory
import org.maia.IContainerFactory
import org.maia.behaviour.scheduler.ISchedulerFactory
import org.maia.initializer.IInitializerService
import org.maia.messaging.IMessageFactory
import org.maia.messaging.queue.IMessageQueueFactory
import org.maia.naming.IAgentNameGenerator
import org.maia.naming.IContainerNameGenerator
import org.maia.service.IServiceManagementService
import org.slf4j.LoggerFactory

class ContainerFactory implements IContainerFactory {

	val static LOGGER = LoggerFactory.getLogger(ContainerFactory)

	@Inject
	IEclipseContext context

	@Inject
	IContainerNameGenerator containerNameGenerator

	@Inject
	IServiceManagementService serviceManagementService

	override createDefault(String id) {
		LOGGER.info("Try to create new Default Container...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	container Id: [{}]", id)

		val result = internalCreateEmpty(id)

		serviceManagementService => [
			createService(result, IAgentNameGenerator)
			createService(result, ISchedulerFactory)
			createService(result, IMessageQueueFactory)
			createService(result, IMessageFactory)
			createService(result, IAgentFactory)
			createService(result, IInitializerService)
		]

		LOGGER.info("Container successfully created!")
		return result
	}

	override createEmpty(String id) {
		LOGGER.info("Try to create new Empty Container...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	container Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Container successfully created!")
		return result
	}

	def IEclipseContext createInternalContext(IEclipseContext ctx, String name) {
		LOGGER.info("Create Internal Container Context...")
		val result = ctx.createChild("Internal context for Container: " + name)
		return result
	}

	private def internalCreateEmpty(String id) {
		val name = if (id != null) {
				id
			} else {
				LOGGER.info("Generate Container Name...")
				containerNameGenerator.generate
			}

		LOGGER.info("Create Container Context...")
		val result = context.createChild("Context for Container: " + name) => [
			declareModifiable(KEY_AGENTS)
			declareModifiable(KEY_NAME)
		]

		LOGGER.info("Add properties to Context...")
		serviceManagementService => [
			addService(result, KEY_NAME, name)
		]

		LOGGER.info("Add link for parent Context...")
		var containers = context.get(KEY_CONTAINERS) as List<IEclipseContext>
		if (containers == null) {
			LOGGER.debug("	Parent Context [{}] have no containers link, create new list...", context)
			containers = new ArrayList<IEclipseContext>
			context.set(KEY_CONTAINERS, containers)
		}
		containers += result

		return result
	}

}