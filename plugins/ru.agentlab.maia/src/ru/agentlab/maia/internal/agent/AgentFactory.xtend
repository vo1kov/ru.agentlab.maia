package ru.agentlab.maia.internal.agent

import java.util.ArrayList
import java.util.List
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.agent.IAgentIdFactory
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.agent.ISchedulerFactory
import ru.agentlab.maia.container.IContainerId
import ru.agentlab.maia.context.ContextExtension
import ru.agentlab.maia.internal.MaiaActivator
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.IMessageQueueFactory
import ru.agentlab.maia.naming.IAgentNameGenerator

/**
 * Factory for creating Agent-Contexts
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class AgentFactory implements IAgentFactory {
	
	val static LOGGER = LoggerFactory.getLogger(AgentFactory)
	
	extension ContextExtension = new ContextExtension(LOGGER)

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
	 * @param root - parent context where agent will be created
	 * @param id - unique id of agent. If <code>null</code>, then 
	 * {@link IAgentNameGenerator IAgentNameGenerator} will be used for generating agent name.
	 */
	override createDefault(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Default Agent...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	agent Id: [{}]", id)

		val context = internalCreateEmpty(root, id)
		val name = context.get(KEY_NAME) as String

		val schedulerFactory = context.get(ISchedulerFactory)
		val scheduler = schedulerFactory.create(name)

		val messageQueueProvider = context.get(IMessageQueueFactory)
		val messageQueue = messageQueueProvider.get

		LOGGER.info("Create Agent-specific Services...")
		context => [
			// Every behaviour can access to scheduler
			addContextService(IScheduler, scheduler)
			// Every behaviour can access to message queue
			addContextService(IMessageQueue, messageQueue)
		]

		LOGGER.info("Agent successfully created!")
		return context
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
	 * @param root - parent context where agent will be created
	 * @param id - unique id of agent. If <code>null</code>, then 
	 * {@link IAgentNameGenerator IAgentNameGenerator} will be used for generating agent name.
	 */
	override createEmpty(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Empty Agent...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	agent Id: [{}]", id)

		val context = internalCreateEmpty(root, id)

		LOGGER.info("Empty Agent successfully created!")
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
				LOGGER.info("Generate Agent Name...")
				val nameGenerator = rootContext.get(IAgentNameGenerator)
				val n = nameGenerator.generate(rootContext)
				LOGGER.debug("	Agent Name is [{}]", n)
				n
			}

		LOGGER.info("Create Agent Context...")
		val context = rootContext.createChild("Context for Agent: " + name) => [
			addContextProperty(KEY_NAME, name)
			addContextProperty(KEY_TYPE, TYPE_AGENT)
		]

		LOGGER.info("Add link for parent Context...")
		var agents = rootContext.get(KEY_AGENTS) as List<IEclipseContext>
		if (agents == null) {
			LOGGER.debug("	Parent Context [{}] have no agents link, create new list...", rootContext)
			agents = new ArrayList<IEclipseContext>
			rootContext.set(KEY_AGENTS, agents)
		}
		agents += context
		
		LOGGER.info("Create Agent ID...")
		// TODO: fix if parent is not container
		val agentIdFactory = context.get(IAgentIdFactory)
		val containerId = context.get(IContainerId)
		val agentId = agentIdFactory.create(containerId, name)
		context.set(IAgentId, agentId)
		
		context
	}

}