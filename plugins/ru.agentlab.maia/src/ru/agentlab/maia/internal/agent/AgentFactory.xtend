package ru.agentlab.maia.internal.agent

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.agent.ISchedulerFactory
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.IMessageQueueFactory
import ru.agentlab.maia.agent.IAgentNameGenerator

class AgentFactory implements IAgentFactory {

	@Inject
	IEclipseContext context

	@Inject
	ISchedulerFactory schedulerProvider

	@Inject
	IMessageQueueFactory messageQueueProvider

	@Inject
	IAgentNameGenerator nameGenerator
	
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
	override create(String id, Class<?> contributorClass) {
		val name = if (id != null) {
				id
			} else {
				nameGenerator.generateName
			}
		val scheduler = schedulerProvider.create(name)
		val messageQueue = messageQueueProvider.get

		// Prepare Agent Context
		val agentContext = context.createChild("Agent [" + name + "] Context") => [
			set(IScheduler, scheduler)
			set(IMessageQueue, messageQueue)
			set(IAgent.KEY_NAME, name)
			set(IAgent.KEY_STATE, IAgent.STATE_INITIATED)
		]

		// Create Agent instance in Context
		val agent = ContextInjectionFactory.make(Agent, agentContext)
		ContextInjectionFactory.invoke(agent, PostConstruct, agentContext, null)
		agentContext.set(IAgent, agent)

		// Create Agent Contributor in Context
		if (contributorClass != null) {
			val contributor = ContextInjectionFactory.make(contributorClass, agentContext)
			ContextInjectionFactory.invoke(contributor, PostConstruct, agentContext, null)
			agentContext.set(IAgent.KEY_CONTRIBUTOR, agent)
		}

		return agent
	}

}