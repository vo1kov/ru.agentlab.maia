package ru.agentlab.maia.internal.agent

import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.agent.IFipaAgentLifecycleService
import ru.agentlab.maia.agent.IllegalAgentState

class FipaAgentLifecycleService implements IFipaAgentLifecycleService {

	override invoke(IAgent agent) throws IllegalAgentState {
		val currentState = agent.state
		if (!currentState.equalsIgnoreCase(State.INITIATED.toString)) {
			throw new IllegalAgentState("Agent in INITIATED state only can be invoked")
		}
		agent => [
			scheduler.start
			changeState(State.ACTIVE)
		]
	}

	override suspend(IAgent agent) throws IllegalAgentState {
		val currentState = agent.state
		if (!currentState.equalsIgnoreCase(State.ACTIVE.toString)) {
			throw new IllegalAgentState("Agent in ACTIVE state only can be suspended")
		}
		agent => [
			scheduler.blockAll
			changeState(State.SUSPENDED)
		]
	}
	
	override void resume(IAgent agent) {
		val currentState = agent.state
		if (!currentState.equalsIgnoreCase(State.SUSPENDED.toString)) {
			throw new IllegalAgentState("Agent in SUSPENDED state only can be resumed")
		}
		agent => [
			scheduler.restartAll
			changeState(State.ACTIVE)
		]
	}

	override wait(IAgent agent) throws IllegalAgentState {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override wakeUp(IAgent agent) throws IllegalAgentState {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override getState(IAgent agent) {
		return agent.context.get(KEY_STATE) as String
	}

	override setState(IAgent agent, String state) throws IllegalAgentState {
		agent.context.set(KEY_STATE, state)
	}

	def private changeState(IAgent agent, State state) {
		agent => [
			context.set(State, state)
			setState(state.toString)
		]
	}

}