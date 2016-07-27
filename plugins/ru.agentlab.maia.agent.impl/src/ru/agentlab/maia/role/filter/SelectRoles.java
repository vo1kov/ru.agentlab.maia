package ru.agentlab.maia.role.filter;

import java.util.Iterator;
import java.util.Map;

import javax.inject.Inject;

import ru.agentlab.maia.agent.IAgent;
import ru.agentlab.maia.filter.IPlanStateFilter;

public class SelectRoles implements IPlanStateFilter {

	Class<?> roleClass;

	@Inject
	IAgent agent;

	public SelectRoles(Class<?> roleClass) {
		this.roleClass = roleClass;
	}

	@Override
	public boolean matches(Object item, Map<String, Object> values) {
		Iterator<Object> result = agent.getRoles().stream().filter(r -> r.getClass() == roleClass).iterator();
		if (result.hasNext()) {
			return true;
		} else {
			return false;
		}
	}

}
