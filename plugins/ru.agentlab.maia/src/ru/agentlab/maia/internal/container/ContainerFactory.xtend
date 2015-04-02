package ru.agentlab.maia.internal.container

import java.util.ArrayList
import java.util.List
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.IAgentIdFactory
import ru.agentlab.maia.agent.ISchedulerFactory
import ru.agentlab.maia.behaviour.sheme.BehaviourSchemeCyclic
import ru.agentlab.maia.behaviour.sheme.BehaviourSchemeOneShot
import ru.agentlab.maia.behaviour.sheme.BehaviourSchemeTicker
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.container.IContainerId
import ru.agentlab.maia.container.IContainerIdFactory
import ru.agentlab.maia.context.IContributionService
import ru.agentlab.maia.internal.agent.AgentFactory
import ru.agentlab.maia.internal.agent.AgentIdFactory
import ru.agentlab.maia.internal.agent.SchedulerFactory
import ru.agentlab.maia.internal.context.ContributionService
import ru.agentlab.maia.internal.messaging.AclMessageFactory
import ru.agentlab.maia.internal.messaging.ArrayBlockingMessageQueueFactory
import ru.agentlab.maia.internal.naming.AgentNameGenerator
import ru.agentlab.maia.messaging.IMessageFactory
import ru.agentlab.maia.messaging.IMessageQueueFactory
import ru.agentlab.maia.naming.IAgentNameGenerator
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

		result => [
			// container layer
			createService(IAgentNameGenerator, AgentNameGenerator)
			createService(IAgentIdFactory, AgentIdFactory)
			createService(ISchedulerFactory, SchedulerFactory)
			createService(IMessageQueueFactory, ArrayBlockingMessageQueueFactory)
			createService(IMessageFactory, AclMessageFactory)
			createService(IAgentFactory, AgentFactory)
			createService(IContributionService, ContributionService)

			createService(BehaviourSchemeOneShot, BehaviourSchemeOneShot)
			createService(BehaviourSchemeCyclic, BehaviourSchemeCyclic)
			createService(BehaviourSchemeTicker, BehaviourSchemeTicker)
		]

		LOGGER.info("Container successfully created!")
		return result
	}

	def private <T> void createService(IEclipseContext ctx, Class<T> serviceClass,
		Class<? extends T> implementationClass) {
		val service = ContextInjectionFactory.make(implementationClass, ctx)
		ContextInjectionFactory.invoke(service, PostConstruct, ctx, null)
		serviceManagementService.addService(ctx, serviceClass, service)
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

		LOGGER.info("Create Container ID...")
		val platformId = result.get(IPlatformId)
		val containerId = containerIdFactory.create(platformId, name, null)
		serviceManagementService.addService(result, IContainerId, containerId)

		return result
	}

}