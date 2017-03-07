package ru.agentlab.maia.agent;

import ru.agentlab.maia.AgentState;
import ru.agentlab.maia.IEvent;

final class ActionExecute extends Action {

	private static final long serialVersionUID = 1L;

	ActionExecute(Agent agent) {
		super(agent);
	}

	@Override
	protected void compute() {
		IEvent<?> event = agent.eventQueue.poll();
		if (event == null) {
			if (agent.getState() == AgentState.ACTIVE) {
				agent.setState(AgentState.WAITING);
			}
			return;
		}

		handleEvent(event);

		if (agent.getState() == AgentState.ACTIVE) {
			agent.executor.submit(new ActionExecute(agent));
		} else {
			agent.setState(AgentState.IDLE);
		}
	}

}