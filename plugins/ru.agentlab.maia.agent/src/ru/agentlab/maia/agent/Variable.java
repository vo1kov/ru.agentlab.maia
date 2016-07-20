package ru.agentlab.maia.agent;

import java.util.Map;

import ru.agentlab.maia.IEventMatcher;

public class Variable implements IEventMatcher {

	private final String name;

	public Variable(String name) {
		this.name = name;
	}

	@Override
	public boolean matches(Object item, Map<String, Object> values) {
		if (values.containsKey(name)) {
			if (values.get(name) == item) {
				return true;
			} else {
				return false;
			}
		} else {
			values.put(name, item);
			return true;
		}
	}

}
