package ru.agentlab.maia.lifecycle.fipa

import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.lifecycle.IAgentLifecycleService
import ru.agentlab.maia.lifecycle.IllegalAgentStateException

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
	def void invoke(IEclipseContext agent) throws IllegalAgentStateException

	def void suspend(IEclipseContext agent) throws IllegalAgentStateException

	def void resume(IEclipseContext agent) throws IllegalAgentStateException

	def void wait(IEclipseContext agent) throws IllegalAgentStateException

	def void wakeUp(IEclipseContext agent) throws IllegalAgentStateException

}