package ru.agentlab.maia.lifecycle.fipa

import ru.agentlab.maia.lifecycle.ILifecycleService
import ru.agentlab.maia.lifecycle.IllegalAgentStateException

interface IFipaLifecycleService extends ILifecycleService {

	/**
	 * The invocation of a new agent. Set state to ACTIVE
	 * @see #State$ACTIVE
	 */
	def void invoke() throws IllegalAgentStateException

	def void suspend() throws IllegalAgentStateException

	def void resume() throws IllegalAgentStateException

}