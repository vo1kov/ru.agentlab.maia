package ru.agentlab.maia.agent.match;

import java.util.Iterator;
import java.util.Map;

import javax.inject.Inject;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.agent.IStateMatcher;

public class SelectRoles implements IStateMatcher {

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
