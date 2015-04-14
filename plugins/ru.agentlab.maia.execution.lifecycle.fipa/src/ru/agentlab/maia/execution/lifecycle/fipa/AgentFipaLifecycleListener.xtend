package ru.agentlab.maia.execution.lifecycle.fipa

import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleTransition

class AgentFipaLifecycleListener extends RunAndTrack {

	override changed(IEclipseContext context) {
		val state = context.get(IMaiaContextLifecycleTransition)
		val scheduler = context.get(IAgentScheduler)
		switch (state) {
			case FipaLifecycleScheme.TRANSITION_INVOKE: {
				scheduler.start
			}
			case FipaLifecycleScheme.TRANSITION_SUSPEND: {
				scheduler.blockAll
			}
			case FipaLifecycleScheme.TRANSITION_RESUME: {
				scheduler.restartAll
			}
			case FipaLifecycleScheme.TRANSITION_DELETE: {
				scheduler.removeAll
			}
		}
		return true
	}

}