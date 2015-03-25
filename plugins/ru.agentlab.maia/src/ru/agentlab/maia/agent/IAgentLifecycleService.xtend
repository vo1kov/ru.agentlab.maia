package ru.agentlab.maia.agent

interface IAgentLifecycleService {

	val static String KEY_STATE = "agent.state"

	def String getState(IAgent agent)

	def void setState(IAgent agent, String state) throws IllegalAgentState

	def Iterable<String> getPossibleStates()

}