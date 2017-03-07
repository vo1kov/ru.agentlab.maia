package ru.agentlab.maia.agent.filter.impl;

import static java.util.stream.Collectors.joining;

import java.util.Collection;
import java.util.Map;

import ru.agentlab.maia.agent.filter.IPlanEventFilter;

public class PlanEventFilterAnyOf<T> implements IPlanEventFilter<T> {

	Collection<IPlanEventFilter<T>> matchers;

	public PlanEventFilterAnyOf(Collection<IPlanEventFilter<T>> matchers) {
		this.matchers = matchers;
	}

	@Override
	public boolean matches(Object event, Map<String, Object> values) {
		for (IPlanEventFilter<T> matcher : matchers) {
			if (matcher.matches(event, values)) {
				return true;
			}
		}
		return false;
	}

	@Override
	public String toString() {
		return "any of: " + matchers.stream().map(Object::toString).collect(joining(", ", "(", ")"));
	}

}
