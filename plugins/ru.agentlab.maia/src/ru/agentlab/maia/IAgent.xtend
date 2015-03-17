package ru.agentlab.maia

interface IAgent {

	val static String KEY_STATE = "agent.state"

	val static String KEY_NAME = "agent.name"

	val static String STATE_INITIATED = "agent.initiated"

	val static String STATE_ACTIVE = "agent.active"

	val static String STATE_IDLE = "agent.idle"

	val static String STATE_SUSPENDED = "agent.suspended"

	val static String STATE_WAITING = "agent.waiting"

	val static String STATE_DELETED = "agent.deleted"

	def void pause()

	def void stop()

	def void addBehaviour(IBehaviour behaviour)

	def void send(IMessage message)

	def IMessage receive(IMessageTemplate template)
	
	def String getState()
}