package ru.agentlab.maia.filter.impl;

import java.util.Map;

import ru.agentlab.maia.filter.IPlanEventFilter;

public class PlanEventFilterVariable implements IPlanEventFilter<Object> {

	private final String name;

	public PlanEventFilterVariable(String name) {
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

	@Override
	public String toString() {
		return "?" + name;
	}

}
