package ru.agentlab.maia.internal.lifecycle.fipa

import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.lifecycle.ILifecycleState
import ru.agentlab.maia.lifecycle.ILifecycleTransition
import ru.agentlab.maia.lifecycle.IllegalAgentStateException
import ru.agentlab.maia.lifecycle.fipa.IFipaLifecycleService

class FipaLifecycleService implements IFipaLifecycleService {

	@Inject
	IEclipseContext context

	val public static STATE_UNKNOWN = new FipaLifecycleState("UNKNOWN")

	val public static STATE_ACTIVE = new FipaLifecycleState("ACTIVE")

	val public static STATE_SUSPENDED = new FipaLifecycleState("SUSPENDED")

	val public static STATE_INITIATED = new FipaLifecycleState("INITIATED")

	val public static STATE_DELETED = new FipaLifecycleState("DELETED")

	override invoke() throws IllegalAgentStateException {
		val currentState = getState
		if (currentState != null) {
			throw new IllegalAgentStateException("Agent already initiated. Use resume() instead")
		}
		context.set(ILifecycleState, STATE_ACTIVE)
		context.runAndTrack [
			val scheduler = get(IScheduler)
			if (scheduler != null) {
				val state = getState
				switch (state) {
					case STATE_ACTIVE: {
						scheduler.start
					}
					case STATE_SUSPENDED: {
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

	override suspend() throws IllegalAgentStateException {
		val currentState = getState
		if (currentState == null || currentState != STATE_ACTIVE) {
			throw new IllegalAgentStateException("Agent in ACTIVE state only can be suspended")
		}
		context => [
			val scheduler = get(IScheduler)
			if (scheduler != null) {
				scheduler.blockAll
				context.set(ILifecycleState, STATE_SUSPENDED)
			} else {
				throw new IllegalAgentStateException("Context have no scheduler. Can't suspend")
			}
		]
	}

	override void resume() {
		val currentState = getState
		if (currentState == null || currentState != STATE_SUSPENDED) {
			throw new IllegalAgentStateException("Agent in SUSPENDED state only can be resumed")
		}
		context => [
			val scheduler = get(IScheduler)
			if (scheduler != null) {
				scheduler.restartAll
				context.set(ILifecycleState, STATE_ACTIVE)
			} else {
				throw new IllegalAgentStateException("Context have no scheduler. Can't resume")
			}
		]
	}

	override getState() {
		return context.getLocal(ILifecycleState)
	}

	override getPossibleStates() {
		return #[
			STATE_UNKNOWN,
			STATE_INITIATED,
			STATE_ACTIVE,
			STATE_SUSPENDED,
			STATE_DELETED
		]
	}

	override setState(ILifecycleState state) throws IllegalAgentStateException {
		switch (state) {
			case STATE_INITIATED: {
				invoke
			}
			case STATE_SUSPENDED: {
				suspend
			}
			case STATE_ACTIVE: {
				resume
			}
		}
	}

	override getStatesTransitions() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}

@Accessors
class FipaLifecycleState implements ILifecycleState {

	var String name

	new(String name) {
		this.name = name
	}

}

@Accessors
class FipaLifecycleTransition implements ILifecycleTransition {

	var String name

	var FipaLifecycleState fromState

	var FipaLifecycleState toState

	new(String name, FipaLifecycleState fromState, FipaLifecycleState toState) {
		this.name = name
		this.fromState = fromState
		this.toState = toState
	}

}