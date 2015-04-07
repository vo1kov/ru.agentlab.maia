package org.maia.internal

import java.util.ArrayList
import java.util.List
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.maia.IAgentFactory
import org.maia.IBehaviourFactory
import org.maia.IContainerFactory
import org.maia.IContextFactory
import org.maia.IPlatformFactory
import org.maia.behaviour.scheduler.ISchedulerFactory
import org.maia.initializer.IInitializerService
import org.maia.messaging.IMessageDeliveryService
import org.maia.messaging.IMessageDeliveryServiceFactory
import org.maia.messaging.IMessageFactory
import org.maia.messaging.queue.IMessageQueueFactory
import org.maia.naming.IContainerNameGenerator
import org.maia.naming.IPlatformNameGenerator
import org.maia.service.IServiceManagementService
import org.slf4j.LoggerFactory

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
		serviceManagementService => [
			createService(result, IContainerNameGenerator)
			createService(result, IContainerFactory)
			createService(result, IInitializerService)

			val fac = createService(result, IMessageDeliveryServiceFactory)
			val mts = fac.create(result)
			addService(result, IMessageDeliveryService, mts)
		]

		LOGGER.info("Platform successfully created!")
		return result
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
			declareModifiable(KEY_NAME)
		]

		LOGGER.info("Add properties to Context...")
		serviceManagementService => [
			addService(result, KEY_NAME, name)
		]

		LOGGER.info("Add link for parent Context...")
		var platforms = context.get(KEY_PLATFORMS) as List<IEclipseContext>
		if (platforms == null) {
			LOGGER.debug("	Parent Context [{}] have no platforms link, create new list...", context)
			platforms = new ArrayList<IEclipseContext>
			context.set(KEY_PLATFORMS, platforms)
		}
		platforms += result

		return result
	}

}