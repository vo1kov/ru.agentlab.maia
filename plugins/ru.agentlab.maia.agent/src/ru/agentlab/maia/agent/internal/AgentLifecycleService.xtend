package ru.agentlab.maia.agent.internal

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.IAgent
import ru.agentlab.maia.IAgentId
import ru.agentlab.maia.IContainerId
import ru.agentlab.maia.agent.IAgentLifecycleService
import ru.agentlab.maia.messageq.IMessageQueue
import ru.agentlab.maia.messageq.IMessageQueueProvider
import ru.agentlab.maia.scheduler.IScheduler
import ru.agentlab.maia.scheduler.ISchedulerProvider
import org.osgi.framework.Bundle
import ru.agentlab.maia.annotation.Setup

class AgentLifecycleService implements IAgentLifecycleService {

	@Inject
	IEclipseContext context

	@Inject
	ISchedulerProvider schedulerProvider

	@Inject
	IMessageQueueProvider messageQueueProvider

	override IAgent bornAgent(String id, IContainerId container, Bundle bundle, String className) {
		val scheduler = schedulerProvider.get
		val messageQueue = messageQueueProvider.get

		val agentContext = context.createChild("Agent [" + id + "] Context") => [
			set(IScheduler, scheduler)
			set(IMessageQueue, messageQueue)
			set(IAgent.KEY_NAME, id)
			set(IAgent.KEY_STATE, IAgent.STATE_INITIATED)
		]
		
		val agent = ContextInjectionFactory.make(Agent, agentContext)
		ContextInjectionFactory.invoke(agent, PostConstruct, agentContext)
		agentContext.set(IAgent, agent)
		
		val contribClass = bundle.loadClass(className)
		
		val contrib = ContextInjectionFactory.make(contribClass, agentContext)
//		ContextInjectionFactory.invoke(contrib, Setup, agentContext)
		ContextInjectionFactory.invoke(contrib, PostConstruct, agentContext)

		return agent
	}

	override pauseAgent(IAgentId agent) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override stopAgent(IAgentId agent) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override resumeAgent(IAgentId agent) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override killAgent(IAgentId agent) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
