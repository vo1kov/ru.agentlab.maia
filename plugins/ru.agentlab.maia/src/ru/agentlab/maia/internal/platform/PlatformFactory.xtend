package ru.agentlab.maia.internal.platform

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
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.container.IContainerIdFactory
import ru.agentlab.maia.context.IContextFactory
import ru.agentlab.maia.context.IContributionService
import ru.agentlab.maia.internal.agent.AgentFactory
import ru.agentlab.maia.internal.agent.AgentIdFactory
import ru.agentlab.maia.internal.agent.SchedulerFactory
import ru.agentlab.maia.internal.behaviour.BehaviourFactory
import ru.agentlab.maia.internal.container.ContainerFactory
import ru.agentlab.maia.internal.container.ContainerIdFactory
import ru.agentlab.maia.internal.messaging.MessageFactory
import ru.agentlab.maia.internal.messaging.MessageQueueFactory
import ru.agentlab.maia.internal.naming.AgentNameGenerator
import ru.agentlab.maia.internal.naming.ContainerNameGenerator
import ru.agentlab.maia.messaging.IMessageDeliveryService
import ru.agentlab.maia.messaging.IMessageDeliveryServiceFactory
import ru.agentlab.maia.messaging.IMessageFactory
import ru.agentlab.maia.messaging.IMessageQueueFactory
import ru.agentlab.maia.naming.IAgentNameGenerator
import ru.agentlab.maia.naming.IBehaviourNameGenerator
import ru.agentlab.maia.naming.IContainerNameGenerator
import ru.agentlab.maia.naming.IPlatformNameGenerator
import ru.agentlab.maia.platform.IPlatformFactory
import ru.agentlab.maia.platform.IPlatformId
import ru.agentlab.maia.platform.IPlatformIdFactory
import ru.agentlab.maia.service.IServiceManagementService
import ru.agentlab.maia.internal.naming.BehaviourNameGenerator

/**
 * Factory for creating new Platforms.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class PlatformFactory implements IPlatformFactory {

	val static LOGGER = LoggerFactory.getLogger(PlatformFactory)

	@Inject
	IEclipseContext context

	@Inject
	IPlatformNameGenerator platformNameGenerator

	@Inject
	IServiceManagementService serviceManagementService

	@Inject
	IPlatformIdFactory platformIdFactory

	@Inject
	IMessageDeliveryServiceFactory messageDeliveryServiceFactory

	/**
	 * <p>Create Platform-Context with default set of platform-specific services.</p>
	 * <p>That implementation of factory create Context with following services:</p>
	 * <ul>
	 * <li>{@link IMessageFactory IMessageFactory} - allow platform and any childs
	 * create new messages</li>
	 * <li>{@link IContainerFactory IContainerFactory} - allow platform and any childs
	 * create new containers</li>
	 * <li>{@link IAgentFactory IAgentFactory} - allow platform and any childs
	 * create new agents</li>
	 * <li>{@link IBehaviourFactory IBehaviourFactory} - allow platform and any childs
	 * create new behaviours</li>
	 * <li>{@link ISchedulerFactory ISchedulerFactory} - allow platform and any childs
	 * create new schedulers</li>
	 * <li>{@link IMessageQueueFactory IMessageQueueFactory} - allow platform and any childs
	 * create new message queues</li>
	 * <li>{@link IMessageDeliveryService IMessageDeliveryService} - allow platform 
	 * and any childs receive messages</li>
	 * </ul>
	 * <p>Context will contain properties:</p>
	 * <ul>
	 * <li><code>context.name</code> - name of context, contains agent name</li>
	 * <li><code>context.type</code> - type of context, contains 
	 * {@link IContextFactory#TYPE_AGENT AGENT} value</li>
	 * <li>{@link IPlatformId IPlatformId} - Id of platform</li>
	 * </ul>
	 * @param root - parent context where platform will be created
	 * @param id - unique id of agent. If <code>null</code>, then 
	 * {@link IPlatformNameGenerator IPlatformNameGenerator} will be used for 
	 * generating platform name.
	 */
	override createDefault(String id) {
		LOGGER.info("Try to create new Default Platform...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	platform Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Create Platform-specific Services...")
		result => [
			// platform layer
			createService(IContainerNameGenerator, ContainerNameGenerator)
			createService(IContainerIdFactory, ContainerIdFactory)
			createService(IContainerFactory, ContainerFactory)
			
			// container layer
			createService(IAgentNameGenerator, AgentNameGenerator)
			createService(IAgentIdFactory, AgentIdFactory)
			createService(ISchedulerFactory, SchedulerFactory)
			createService(IMessageQueueFactory, MessageQueueFactory)
			createService(IMessageFactory, MessageFactory)
			createService(IAgentFactory, AgentFactory)
			
			// agent layer
			createService(IBehaviourNameGenerator, BehaviourNameGenerator)
			createService(IBehaviourFactory, BehaviourFactory)
			
		]
		
		serviceManagementService => [
			ContextInjectionFactory.invoke(messageDeliveryServiceFactory, PostConstruct, result, null)
			val mts = messageDeliveryServiceFactory.create(result)
			addService(result, IMessageDeliveryService, mts)
		]

		LOGGER.info("Platform successfully created!")
		return result
	}

	def private <T> void createService(IEclipseContext ctx, Class<T> serviceClass, Class<? extends T> implementationClass) {
		val service = ContextInjectionFactory.make(implementationClass, ctx)
		ContextInjectionFactory.invoke(service, PostConstruct, ctx, null)
		serviceManagementService.addService(ctx, serviceClass, service)
	}

	/**
	 * <p>Create Platform-Context without any platform-specific services.</p>
	 * <p>Context will contain properties:</p>
	 * <ul>
	 * <li><code>context.name</code> - name of context, contains platform name</li>
	 * <li><code>context.type</code> - type of context, contains 
	 * {@link IContextFactory#TYPE_PLATFORM PLATFORM} value</li>
	 * <li>{@link IPlatformId IPlatformId} - Id of platform</li>
	 * </ul>
	 * @param root - parent context where platform will be created
	 * @param id - unique id of agent. If <code>null</code>, then 
	 * {@link IPlatformNameGenerator IPlatformNameGenerator} will be used for 
	 * generating platform name.
	 */
	override IEclipseContext createEmpty(String id) {
		LOGGER.info("Try to create new Empty Platform...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	platform Id: [{}]", id)

		val context = internalCreateEmpty(id)

		LOGGER.info("Platform successfully created!")
		return context
	}

	private def internalCreateEmpty(String id) {
		val name = if (id != null) {
				id
			} else {
				LOGGER.info("Generate Platform Name...")
				platformNameGenerator.generate
			}

		LOGGER.info("Create Platform Context...")
		val result = context.createChild("Context for Platform: " + name) => [
			declareModifiable(KEY_CONTAINERS)
			declareModifiable(IContributionService.KEY_CONTRIBUTOR)
		]

		LOGGER.info("Add properties to Context...")
		serviceManagementService => [
			addService(result, KEY_NAME, name)
			addService(result, KEY_TYPE, TYPE_PLATFORM)
		]

		LOGGER.info("Add link for parent Context...")
		var platforms = context.get(KEY_PLATFORMS) as List<IEclipseContext>
		if (platforms == null) {
			LOGGER.debug("	Parent Context [{}] have no platforms link, create new list...", context)
			platforms = new ArrayList<IEclipseContext>
			context.set(KEY_PLATFORMS, platforms)
		}
		platforms += result

		LOGGER.info("Create Platform ID...")
		val platformId = platformIdFactory.create(name)
		serviceManagementService.addService(result, IPlatformId, platformId)

		return result
	}

}