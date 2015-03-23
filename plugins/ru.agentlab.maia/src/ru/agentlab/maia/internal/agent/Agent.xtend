package ru.agentlab.maia.internal.agent

import java.util.ArrayList
import java.util.List
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.container.IContainer
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.IMessageTemplate

@Accessors
class Agent implements IAgent {

	@Inject
	IEclipseContext context

	@Inject
	IAgentId id

	@Inject
	IContainer root

	List<IBehaviour> childs = new ArrayList<IBehaviour>

	@Inject
	IScheduler scheduler

	@Inject
	IMessageQueue queue

	override receive(IMessageTemplate template) {
		queue.receive(template)
	}

	override send(IMessage message) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
