package ru.agentlab.maia.agent.impl;

import ru.agentlab.maia.agent.AgentState;

final class ActionExecute extends Action {

	private static final long serialVersionUID = 1L;

	ActionExecute(Agent agent) {
		super(agent);
	}

	@Override
	protected void compute() {
		Object event = agent.eventQueue.poll();
		if (event == null) {
			agent.setState(AgentState.WAITING);
			return;
		}

		handleEvent(event);

		if (agent.isActive()) {
			agent.executor.submit(new ActionExecute(agent));
		} else {
			agent.setState(AgentState.IDLE);
		}
	}

}