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

class AgentFactory implements IAgentFactory {

	@Inject
	IEclipseContext context

	@Inject
	ISchedulerFactory schedulerProvider

	@Inject
	IMessageQueueFactory messageQueueProvider

	override create(String id, Class<?> contributorClass) {
		val scheduler = schedulerProvider.get
		val messageQueue = messageQueueProvider.get

		// Prepare Agent Context
		val agentContext = context.createChild("Agent [" + id + "] Context") => [
			set(IScheduler, scheduler)
			set(IMessageQueue, messageQueue)
			set(IAgent.KEY_NAME, id)
			set(IAgent.KEY_STATE, IAgent.STATE_INITIATED)
		]

		// Create Agent instance in Context
		val agent = ContextInjectionFactory.make(Agent, agentContext)
		try {
			ContextInjectionFactory.invoke(agent, PostConstruct, agentContext)
		} catch (Exception e) {
//			e.printStackTrace
		}
		agentContext.set(IAgent, agent)

		// Create Agent Contributor in Context
		val contributor = ContextInjectionFactory.make(contributorClass, agentContext)
		try {
			ContextInjectionFactory.invoke(contributor, PostConstruct, agentContext)
		} catch (Exception e) {
//			e.printStackTrace
		}

		// test
		agentContext.set(IAgent.KEY_STATE, IAgent.STATE_ACTIVE)
		agentContext.set(IAgent.KEY_STATE, IAgent.STATE_IDLE)
		agentContext.set(IAgent.KEY_STATE, IAgent.STATE_ACTIVE)
		return agent
	}

}