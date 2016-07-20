package ru.agentlab.maia.match;

import java.util.Map;

import ru.agentlab.maia.IEventMatcher;

public class EventMatcherVariable implements IEventMatcher {

	private final String name;

	public EventMatcherVariable(String name) {
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
