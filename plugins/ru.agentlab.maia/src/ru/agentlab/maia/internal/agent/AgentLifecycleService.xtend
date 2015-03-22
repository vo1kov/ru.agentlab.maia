package ru.agentlab.maia.internal.agent

import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.agent.IAgentLifecycleService

class AgentLifecycleService implements IAgentLifecycleService {

	override void pause(IAgent agent) {
	}

	override void stop(IAgent agent) {
		agent => [
			scheduler.blockAll
			context.set(KEY_STATE, STATE_IDLE)
		]
	}

	override void resume(IAgent agent) {
		agent => [
			scheduler.restartAll
			context.set(KEY_STATE, STATE_ACTIVE)
		]
	}

	override getState(IAgent agent) {
		return agent.context.get(KEY_STATE) as String
	}
}