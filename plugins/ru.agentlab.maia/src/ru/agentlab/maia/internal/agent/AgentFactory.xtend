package ru.agentlab.maia.internal.agent

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.agent.IAgentIdFactory
import ru.agentlab.maia.agent.IAgentLifecycleService
import ru.agentlab.maia.agent.IAgentNameGenerator
import ru.agentlab.maia.agent.IFipaAgentLifecycleService
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.agent.ISchedulerFactory
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.container.IContainer
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.IMessageQueueFactory

class AgentFactory implements IAgentFactory {

	val static LOGGER = LoggerFactory.getLogger(AgentFactory)

	@Inject
	IEclipseContext context

	@Inject
	ISchedulerFactory schedulerProvider

	@Inject
	IMessageQueueFactory messageQueueProvider

	@Inject
	IAgentNameGenerator nameGenerator

	@Inject
	IAgentIdFactory agentIdFactory

	/**
	 * Create agent instance
	 * 
	 * @param id
	 * 			- unique id of agent. If <code>null</code>, then <code>IAgentNameGenerator</code> 
	 * 			will be used for generating agent name.
	 * @param contributorClass
	 * 			- class that contain customization of agent realization. Contributor class 
	 * 			is simple POJO. Services can be accessed via injection. If <code>null</code> then 
	 * 			default agent realization will be used.
	 */
	override create(IContainer container, String id, Class<?> contributorClass) {
		LOGGER.info("Prepare Agent Name...")
		val name = if (id != null) {
				id
			} else {
				nameGenerator.generateName(container)
			}

		val scheduler = schedulerProvider.create(name)
		val messageQueue = messageQueueProvider.get

		LOGGER.info("Prepare Agent Context...")
		val agentContext = container.context.createChild("Agent [" + name + "] Context") => [
			set(IScheduler, scheduler)
			set(IMessageQueue, messageQueue)
			set(IAgent.KEY_NAME, name)
			set(IAgentLifecycleService.KEY_STATE, IFipaAgentLifecycleService.State.INITIATED.toString)
		]

		LOGGER.info("Prepare Agent-layer Services...")
		agentContext.set(IBehaviourFactory, context.get(IBehaviourFactory))

		LOGGER.info("Prepare AgentID in Context...")
		val agentId = agentIdFactory.create(container.id, name)
		agentContext.set(IAgentId, agentId)

		LOGGER.info("Prepare Agent Instance in Context...")
		val agent = ContextInjectionFactory.make(Agent, agentContext)
		ContextInjectionFactory.invoke(agent, PostConstruct, agentContext, null)
		agentContext.set(IAgent, agent)

		LOGGER.info("Prepare Agent Contributor in Context...")
		if (contributorClass != null) {
			val contributor = ContextInjectionFactory.make(contributorClass, agentContext)
			agentContext.set(IAgent.KEY_CONTRIBUTOR, contributor)
			ContextInjectionFactory.invoke(contributor, PostConstruct, agentContext, null)
		}

		return agent
	}

}