package ru.agentlab.maia.agent.match;

import ru.agentlab.maia.IAgent;

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
