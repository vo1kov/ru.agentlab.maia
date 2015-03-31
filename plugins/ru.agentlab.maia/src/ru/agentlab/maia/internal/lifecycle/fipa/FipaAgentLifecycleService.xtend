package ru.agentlab.maia.internal.lifecycle.fipa

import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.lifecycle.IllegalAgentStateException
import ru.agentlab.maia.lifecycle.fipa.IFipaAgentLifecycleService

class FipaAgentLifecycleService implements IFipaAgentLifecycleService {
	
	override invoke(IEclipseContext context) throws IllegalAgentStateException {
		val currentState = context.state
		if (currentState != null) {
			throw new IllegalAgentStateException("Agent already initiated. Use resume() instead")
		}
		context.changeState(State.ACTIVE)
		context.runAndTrack [
			val scheduler = get(IScheduler)
			if (scheduler != null) {
				val state = get(KEY_STATE)
				switch (state) {
					case State.ACTIVE.toString: {
						scheduler.start
					}
					case State.SUSPENDED.toString: {
						scheduler.start
						scheduler.blockAll
					}
				}
				return true
			} else {
				throw new IllegalAgentStateException("Context have no scheduler. Can't invoke")
			}
		]
	}

	override suspend(IEclipseContext context) throws IllegalAgentStateException {
		val currentState = context.state
		if (currentState == null || !currentState.equalsIgnoreCase(State.ACTIVE.toString)) {
			throw new IllegalAgentStateException("Agent in ACTIVE state only can be suspended")
		}
		context => [
			val scheduler = get(IScheduler)
			if (scheduler != null) {
				scheduler.blockAll
				changeState(State.SUSPENDED)
			} else {
				throw new IllegalAgentStateException("Context have no scheduler. Can't suspend")
			}
		]
	}

	override void resume(IEclipseContext context) {
		val currentState = context.state
		if (currentState == null || !currentState.equalsIgnoreCase(State.SUSPENDED.toString)) {
			throw new IllegalAgentStateException("Agent in SUSPENDED state only can be resumed")
		}
		context => [
			val scheduler = get(IScheduler)
			if (scheduler != null) {
				scheduler.restartAll
				changeState(State.ACTIVE)
			} else {
				throw new IllegalAgentStateException("Context have no scheduler. Can't resume")
			}
		]
	}

	override wait(IEclipseContext context) throws IllegalAgentStateException {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override wakeUp(IEclipseContext context) throws IllegalAgentStateException {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override getState(IEclipseContext context) {
		return context.getLocal(KEY_STATE) as String
	}

	override setState(IEclipseContext context, String state) throws IllegalAgentStateException {
		switch (state) {
			case State.INITIATED.toString: {
				context.invoke
			}
			case State.SUSPENDED.toString: {
				context.suspend
			}
			case State.ACTIVE.toString: {
				context.resume
			}
		}
	}

	def private changeState(IEclipseContext context, State state) {
		context => [
			set(State, state)
			set(KEY_STATE, state.toString)
		]
	}

	override getPossibleStates() {
		return #[
			State.UNKNOWN.toString,
			State.INITIATED.toString,
			State.ACTIVE.toString,
			State.SUSPENDED.toString,
			State.WAITING.toString,
			State.DELETED.toString
		]
	}

}