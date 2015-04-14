package ru.agentlab.maia.lifecycle.fipa

import ru.agentlab.maia.lifecycle.ILifecycleTransition

class AgentFipaLifecycleListener extends RunAndTrack {

	override changed(IEclipseContext context) {
		val state = context.get(ILifecycleTransition)
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