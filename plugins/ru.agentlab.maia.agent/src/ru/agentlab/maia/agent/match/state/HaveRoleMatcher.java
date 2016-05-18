package ru.agentlab.maia.agent.match.state;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.agent.IStateMatcher;

public class HaveRoleMatcher implements IStateMatcher {

	Class<?> clazz;

	public HaveRoleMatcher(Class<?> template) {
		this.clazz = template;
	}

	@Override
	public boolean match(IAgent agent) {
		return false;
	}

}
