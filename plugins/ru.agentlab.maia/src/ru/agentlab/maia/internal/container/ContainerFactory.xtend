package ru.agentlab.maia.internal.container

import java.util.ArrayList
import java.util.List
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.IAgentIdFactory
import ru.agentlab.maia.agent.ISchedulerFactory
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.container.IContainerId
import ru.agentlab.maia.container.IContainerIdFactory
import ru.agentlab.maia.context.IContributionService
import ru.agentlab.maia.messaging.IMessageFactory
import ru.agentlab.maia.messaging.IMessageQueueFactory
import ru.agentlab.maia.naming.IAgentNameGenerator
import ru.agentlab.maia.naming.IBehaviourNameGenerator
import ru.agentlab.maia.naming.IContainerNameGenerator
import ru.agentlab.maia.platform.IPlatformId
import ru.agentlab.maia.service.IServiceManagementService

class ContainerFactory implements IContainerFactory {

	val static LOGGER = LoggerFactory.getLogger(ContainerFactory)

	@Inject
	IEclipseContext context

	@Inject
	IContainerNameGenerator containerNameGenerator

	@Inject
	IServiceManagementService serviceManagementService

	@Inject
	IContainerIdFactory containerIdFactory

	override createDefault(String id) {
		LOGGER.info("Try to create new Default Container...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	container Id: [{}]", id)

		val result = internalCreateEmpty(id)
		
		serviceManagementService=> [
			// container layer
			moveService(context, result, IAgentNameGenerator)
			moveService(context, result, IAgentIdFactory)
			moveService(context, result, ISchedulerFactory)
			moveService(context, result, IMessageQueueFactory)
			moveService(context, result, IMessageFactory)
			moveService(context, result, IAgentFactory)
			
			// agent layer
			moveService(context, result, IBehaviourNameGenerator)
			moveService(context, result, IBehaviourFactory)
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
			declareModifiable(IContributionService.KEY_CONTRIBUTOR)
		]

		LOGGER.info("Add properties to Context...")
		serviceManagementService => [
			addService(result, KEY_NAME, name)
			addService(result, KEY_TYPE, TYPE_CONTAINER)
		]

		LOGGER.info("Add link for parent Context...")
		var containers = context.get(KEY_CONTAINERS) as List<IEclipseContext>
		if (containers == null) {
			LOGGER.debug("	Parent Context [{}] have no containers link, create new list...", context)
			containers = new ArrayList<IEclipseContext>
			context.set(KEY_CONTAINERS, containers)
		}
		containers += result

		LOGGER.info("Create Container ID...")
		val platformId = result.get(IPlatformId)
		val containerId = containerIdFactory.create(platformId, name, null)
		serviceManagementService.addService(result, IContainerId, containerId)

		return result
	}

}