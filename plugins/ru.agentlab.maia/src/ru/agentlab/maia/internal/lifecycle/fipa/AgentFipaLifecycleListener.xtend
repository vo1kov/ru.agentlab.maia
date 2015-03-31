package ru.agentlab.maia.internal.lifecycle.fipa

import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.contexts.RunAndTrack
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.lifecycle.ILifecycleTransition

class AgentFipaLifecycleListener extends RunAndTrack {

	override changed(IEclipseContext context) {
		val state = context.get(ILifecycleTransition)
		val scheduler = context.get(IScheduler)
		switch (state) {
			case FipaLifecycleSchema.TRANSITION_INVOKE: {
				scheduler.start
			}
			case FipaLifecycleSchema.TRANSITION_SUSPEND: {
				scheduler.blockAll
			}
			case FipaLifecycleSchema.TRANSITION_RESUME: {
				scheduler.restartAll
			}
			case FipaLifecycleSchema.TRANSITION_DELETE: {
				scheduler.removeAll
			}
		}
		return true
	}

}