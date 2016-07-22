package ru.agentlab.maia.agent.role.match;

import java.util.Map;

import javax.inject.Inject;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IStateMatcher;

public class AskForRole implements IStateMatcher {

	Class<?> roleClass;

	@Inject
	IAgent agent;

	public AskForRole(Class<?> roleClass) {
		this.roleClass = roleClass;
	}

	@Override
	public boolean matches(Object item, Map<String, Object> values) {
		return agent.getRoles().stream().filter(r -> r.getClass() == roleClass).findAny().isPresent();
	}

}
