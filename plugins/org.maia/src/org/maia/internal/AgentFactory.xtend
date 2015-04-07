package org.maia.internal

import java.util.ArrayList
import java.util.List
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.maia.IAgentFactory
import org.maia.IBehaviourFactory
import org.maia.IContextFactory
import org.maia.behaviour.scheduler.IScheduler
import org.maia.initializer.IInitializerService
import org.maia.lifecycle.scheme.ILifecycleScheme
import org.maia.messaging.queue.IMessageQueue
import org.maia.naming.IAgentNameGenerator
import org.maia.naming.IBehaviourNameGenerator
import org.maia.service.IServiceManagementService
import org.slf4j.LoggerFactory

/**
 * Factory for creating Agent-Contexts
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class AgentFactory implements IAgentFactory {

	val static LOGGER = LoggerFactory.getLogger(AgentFactory)

	@Inject
	IEclipseContext context

	@Inject
	IAgentNameGenerator agentNameGenerator

	@Inject
	IServiceManagementService serviceManagementService

	@Inject
	LocalAgentRegistry agentRegistryLocal

	/**
	 * <p>Create Agent-Context with default set of agent-specific services.</p>
	 * <p>That implementation of factory create Context with following services:</p>
	 * <ul>
	 * <li>{@link IScheduler IScheduler} - allow agent and all its childs schedules behaviours
	 * and control agent lifecycle</li>
	 * <li>{@link IMessageQueue IMessageQueue} - allow agent and all its childs receives messages</li>
	 * </ul>
	 * <p>Agent-Context will contain properties:</p>
	 * <ul>
	 * <li><code>context.name</code> - name of context, contains agent name</li>
	 * <li><code>context.type</code> - type of context, contains 
	 * {@link IContextFactory#TYPE_AGENT AGENT} value</li>
	 * <li>{@link IAgentId IAgentId} - Id of agent</li>
	 * </ul>
	 * @param id - unique id of agent. If <code>null</code>, then 
	 * {@link IAgentNameGenerator IAgentNameGenerator} will be used for generating agent name.
	 */
	override createDefault(String id) {
		LOGGER.info("Try to create new Default Agent...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	agent Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Create Agent-specific Services...")

		serviceManagementService => [
			createService(result, IBehaviourNameGenerator)
			createService(result, IBehaviourFactory)
			createService(result, ILifecycleScheme)
//			createService(result, ILifecycleService)
			createService(result, IScheduler)
			createService(result, IMessageQueue)
			createService(result, IInitializerService)
		]

//		result => [
//			val service = ContextInjectionFactory.make(AgentFipaLifecycleListener, it)
//			set(AgentFipaLifecycleListener, service)
//			ContextInjectionFactory.invoke(service, PostConstruct, it, null)
//			runAndTrack(service)
//		]
		LOGGER.info("Agent successfully created!")
		return result
	}

	/**
	 * <p>Create Agent-Context without any agent-specific services.</p>
	 * <p>Context will contain properties:</p>
	 * <ul>
	 * <li><code>context.name</code> - name of context, contains agent name</li>
	 * <li><code>context.type</code> - type of context, contains 
	 * {@link IContextFactory#TYPE_AGENT AGENT} value</li>
	 * <li>{@link IAgentId IAgentId} - Id of agent</li>
	 * </ul>
	 * @param id - unique id of agent. If <code>null</code>, then 
	 * {@link IAgentNameGenerator IAgentNameGenerator} will be used for generating agent name.
	 */
	override createEmpty(String id) {
		LOGGER.info("Try to create new Empty Agent...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	agent Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Empty Agent successfully created!")
		return result
	}

	private def internalCreateEmpty(String id) {
		val name = if (id != null) {
				id
			} else {
				LOGGER.info("Generate Agent Name...")
				agentNameGenerator.generate
			}

		LOGGER.info("Create Agent Context...")
		val result = context.createChild("Context for Agent: " + name) => [
			declareModifiable(KEY_BEHAVIOURS)
		]

		LOGGER.info("Add properties to Context...")
		serviceManagementService => [
			addService(result, KEY_NAME, name)
		]

		LOGGER.info("Add link for parent Context...")
		var agents = context.get(KEY_AGENTS) as List<IEclipseContext>
		if (agents == null) {
			LOGGER.debug("	Parent Context [{}] have no agents link, create new list...", context)
			agents = new ArrayList<IEclipseContext>
			context.set(KEY_AGENTS, agents)
		}
		agents += result

		agentRegistryLocal.put(name, result)

		return result
	}

}