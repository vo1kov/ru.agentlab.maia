package ru.agentlab.maia.agent.match;

import java.util.Map;

import javax.inject.Inject;

import ru.agentlab.maia.IAgent;

public class AskForRole {

	Class<?> roleClass;

	@Inject
	IAgent agent;

	public AskForRole(Class<?> roleClass) {
		this.roleClass = roleClass;
	}

	public boolean ask(Map<String, Object> values) {
		return agent.getRoles().stream().filter(r -> r.getClass() == roleClass).findAny().isPresent();
	}

}
