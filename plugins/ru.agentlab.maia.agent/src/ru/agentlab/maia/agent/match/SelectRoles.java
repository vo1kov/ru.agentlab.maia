package ru.agentlab.maia.agent.match;

import java.util.Iterator;
import java.util.Map;

import javax.inject.Inject;

import ru.agentlab.maia.IAgent;

public class SelectRoles {

	Class<?> roleClass;

	@Inject
	IAgent agent;

	public SelectRoles(Class<?> roleClass) {
		this.roleClass = roleClass;
	}

	public boolean ask(Map<String, Object> values) {
		Iterator<Object> result = agent.getRoles().stream().filter(r -> r.getClass() == roleClass).iterator();
		if (result.hasNext()) {
			return true;
		} else {
			return false;
		}
	}

}
