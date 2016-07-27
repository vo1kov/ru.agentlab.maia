package ru.agentlab.maia.role.filter;

import java.util.Map;

import javax.inject.Inject;

import ru.agentlab.maia.agent.IAgent;
import ru.agentlab.maia.filter.IPlanStateFilter;

public class AskForRole implements IPlanStateFilter {

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
