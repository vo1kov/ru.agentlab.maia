package ru.agentlab.maia.agent

interface IAgentLifecycleService {
	
	val static String KEY_STATE = "agent.state"

	val static String STATE_INITIATED = "INITIATED"

	val static String STATE_ACTIVE = "ACTIVE"

	val static String STATE_IDLE = "IDLE"

	val static String STATE_SUSPENDED = "SUSPENDED"

	val static String STATE_WAITING = "WAITING"

	val static String STATE_DELETED = "DELETED"

	def void pause(IAgent agent)

	def void stop(IAgent agent)

	def String getState(IAgent agent)

	def void resume(IAgent agent)

}