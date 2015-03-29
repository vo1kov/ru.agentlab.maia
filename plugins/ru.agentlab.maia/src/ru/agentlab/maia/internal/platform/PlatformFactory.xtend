package ru.agentlab.maia.internal.platform

import java.util.ArrayList
import java.util.List
import javax.annotation.PostConstruct
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.IServiceManagementService
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.ISchedulerFactory
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.context.ContextExtension
import ru.agentlab.maia.context.IContextFactory
import ru.agentlab.maia.internal.MaiaActivator
import ru.agentlab.maia.messaging.IMessageDeliveryService
import ru.agentlab.maia.messaging.IMessageDeliveryServiceFactory
import ru.agentlab.maia.messaging.IMessageFactory
import ru.agentlab.maia.messaging.IMessageQueueFactory
import ru.agentlab.maia.naming.INameGenerator
import ru.agentlab.maia.naming.IPlatformNameGenerator
import ru.agentlab.maia.platform.IPlatformFactory
import ru.agentlab.maia.platform.IPlatformId
import ru.agentlab.maia.platform.IPlatformIdFactory

/**
 * Factory for creating new Platforms.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class PlatformFactory implements IPlatformFactory {

	val static LOGGER = LoggerFactory.getLogger(PlatformFactory)

	extension ContextExtension = new ContextExtension(LOGGER)

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
	 * </ul>
	 * @param root - parent context where platform will be created
	 * @param id - unique id of agent. If <code>null</code>, then 
	 * {@link IPlatformNameGenerator IPlatformNameGenerator} will be used for 
	 * generating platform name.
	 */
	override createDefault(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Default Platform...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	platform Id: [{}]", id)

		val context = internalCreateEmpty(root, id)

		LOGGER.info("Create Platform-specific Services...")
		context.parent.get(IServiceManagementService) => [
			copyFromRoot(context, IMessageFactory)
			copyFromRoot(context, IAgentFactory)
			copyFromRoot(context, IContainerFactory)
			copyFromRoot(context, IBehaviourFactory)
			copyFromRoot(context, ISchedulerFactory)
			copyFromRoot(context, IMessageQueueFactory)
		]

		LOGGER.debug("	Put [{}] Service to context...", IMessageDeliveryService.simpleName)
		val mtsFactory = context.parent.get(IMessageDeliveryServiceFactory)
		ContextInjectionFactory.invoke(mtsFactory, PostConstruct, context, null)
		val mts = mtsFactory.create
		context.set(IMessageDeliveryService, mts)
		
		LOGGER.info("Create Platform ID...")
		val platformIdFactory = context.parent.get(IPlatformIdFactory)
		val platformId = platformIdFactory.create(context.get(KEY_NAME) as String)
		LOGGER.debug("	Put [{}] to context...", platformId)
		context.set(IPlatformId, platformId)

		LOGGER.info("Platform successfully created!")
		return context
	}

	 /**
	 * <p>Create Platform-Context without any platform-specific services.</p>
	 * <p>Context will contain properties:</p>
	 * <ul>
	 * <li><code>context.name</code> - name of context, contains platform name</li>
	 * <li><code>context.type</code> - type of context, contains 
	 * {@link IContextFactory#TYPE_PLATFORM PLATFORM} value</li>
	 * </ul>
	 * @param root - parent context where platform will be created
	 * @param id - unique id of agent. If <code>null</code>, then 
	 * {@link IPlatformNameGenerator IPlatformNameGenerator} will be used for 
	 * generating platform name.
	 */
	override IEclipseContext createEmpty(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Empty Platform...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	platform Id: [{}]", id)

		val context = internalCreateEmpty(root, id)

		LOGGER.info("Platform successfully created!")
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
				LOGGER.info("Generate Platform Name...")
				val nameGenerator = rootContext.get(INameGenerator)
				val n = nameGenerator.generate(rootContext)
				LOGGER.debug("	Platform Name is [{}]", n)
				n
			}

		LOGGER.info("Create Platform Context...")
		val context = rootContext.createChild("Context for Platform: " + name) => [
			declareModifiable(KEY_CONTAINERS)
			addContextProperty(KEY_NAME, name)
			addContextProperty(KEY_TYPE, TYPE_PLATFORM)
		]

		LOGGER.info("Add link for parent Context...")
		var platforms = rootContext.get(KEY_PLATFORMS) as List<IEclipseContext>
		if (platforms == null) {
			LOGGER.debug("	Parent Context [{}] have no platforms link, create new list...", rootContext)
			platforms = new ArrayList<IEclipseContext>
			rootContext.set(KEY_PLATFORMS, platforms)
		}
		platforms += context
		return context
	}

}