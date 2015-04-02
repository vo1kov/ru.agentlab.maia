package ru.agentlab.maia.internal.agent

import java.util.ArrayList
import java.util.List
import java.util.concurrent.ConcurrentLinkedDeque
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.agent.IAgentIdFactory
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.container.IContainerId
import ru.agentlab.maia.context.IContextFactory
import ru.agentlab.maia.context.IContributionService
import ru.agentlab.maia.internal.behaviour.BehaviourFactory
import ru.agentlab.maia.internal.context.ContributionService
import ru.agentlab.maia.internal.lifecycle.LifecycleService
import ru.agentlab.maia.internal.lifecycle.scheme.AgentFipaLifecycleListener
import ru.agentlab.maia.internal.messaging.ArrayBlockingMessageQueue
import ru.agentlab.maia.internal.naming.BehaviourNameGenerator
import ru.agentlab.maia.lifecycle.ILifecycleService
import ru.agentlab.maia.lifecycle.scheme.ILifecycleScheme
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.naming.IAgentNameGenerator
import ru.agentlab.maia.naming.IBehaviourNameGenerator
import ru.agentlab.maia.service.IServiceManagementService
import ru.agentlab.maia.internal.lifecycle.scheme.FipaLifecycleScheme

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
	IAgentIdFactory agentIdFactory

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

		result => [
			// agent layer
			createService(IBehaviourNameGenerator, BehaviourNameGenerator)
			createService(IBehaviourFactory, BehaviourFactory)

			createService(ILifecycleScheme, FipaLifecycleScheme)
			createService(ILifecycleService, LifecycleService)

			createService(IScheduler, Scheduler)
			createService(IMessageQueue, ArrayBlockingMessageQueue)

			createService(IContributionService, ContributionService)

			serviceManagementService.addService(it, "agent.messageQueue", new ConcurrentLinkedDeque<IMessage>)

			val service = ContextInjectionFactory.make(AgentFipaLifecycleListener, it)
			set(AgentFipaLifecycleListener, service)
			ContextInjectionFactory.invoke(service, PostConstruct, it, null)
			runAndTrack(service)
		]

		LOGGER.info("Agent successfully created!")
		return result
	}

	def private <T> void createService(IEclipseContext ctx, Class<T> serviceClass,
		Class<? extends T> implementationClass) {
		val service = ContextInjectionFactory.make(implementationClass, ctx)
		ContextInjectionFactory.invoke(service, PostConstruct, ctx, null)
		serviceManagementService.addService(ctx, serviceClass, service)
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

		LOGGER.info("Create Agent ID...")
		// TODO: fix if parent is not container
		val containerId = result.get(IContainerId)
		val agentId = agentIdFactory.create(containerId, name)
		result.set(IAgentId, agentId)

		agentRegistryLocal.put(agentId, result)

		return result
	}

}