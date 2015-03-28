package ru.agentlab.maia.agent

import java.util.List
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.container.IContainer
import ru.agentlab.maia.messaging.IMessageQueue

interface IAgent {

	val static String KEY_NAME = "agent.name"

	val static String KEY_CONTRIBUTOR = "agent.contributor"

	def IScheduler getScheduler()

	def IMessageQueue getQueue()

	def IEclipseContext getContext()

	def IAgentId getId()

	def IContainer getRoot()

	def List<IBehaviour> getChilds()

	def void setId(IAgentId id)

}