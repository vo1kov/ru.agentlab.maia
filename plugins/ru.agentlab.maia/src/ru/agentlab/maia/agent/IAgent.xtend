package ru.agentlab.maia.agent

import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageTemplate

interface IAgent {

	val static String KEY_STATE = "agent.state"

	val static String KEY_NAME = "agent.name"

	val static String KEY_CONTRIBUTOR = "agent.contributor"

	val static String STATE_INITIATED = "INITIATED"

	val static String STATE_ACTIVE = "ACTIVE"

	val static String STATE_IDLE = "IDLE"

	val static String STATE_SUSPENDED = "SUSPENDED"

	val static String STATE_WAITING = "WAITING"

	val static String STATE_DELETED = "DELETED"

	def void pause()

	def void stop()

	def void addBehaviour(String id, Class<?> contributorClass)

	def void send(IMessage message)

	def IMessage receive(IMessageTemplate template)

	def String getState()

	def IEclipseContext getContext()

	def void resume()

}