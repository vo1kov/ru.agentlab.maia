package ru.agentlab.maia.agent

import java.util.List
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.container.IContainer
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.IMessageTemplate

interface IAgent {

	val static String KEY_NAME = "agent.name"

	val static String KEY_CONTRIBUTOR = "agent.contributor"

	def IScheduler getScheduler()

	def IMessageQueue getQueue()

	def void addBehaviour(String id, Class<?> contributorClass)

	def void send(IMessage message)

	def IMessage receive(IMessageTemplate template)

	def IEclipseContext getContext()

	def IAgentId getId()

	def IContainer getRoot()

	def List<IBehaviour> getChilds()

	def void setId(IAgentId id)

}