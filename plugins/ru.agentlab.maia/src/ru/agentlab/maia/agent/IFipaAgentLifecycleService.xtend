package ru.agentlab.maia.agent

interface IFipaAgentLifecycleService extends IAgentLifecycleService {

	enum State {

		UNKNOWN,
		INITIATED,
		ACTIVE,
		SUSPENDED,
		WAITING,
		DELETED

	}
	
	/**
	 * The invocation of a new agent. Set state to ACTIVE
	 * @see #State$ACTIVE
	 */
	def void invoke(IAgent agent) throws IllegalAgentState

	def void suspend(IAgent agent) throws IllegalAgentState

	def void resume(IAgent agent) throws IllegalAgentState

	def void wait(IAgent agent) throws IllegalAgentState

	def void wakeUp(IAgent agent) throws IllegalAgentState

}