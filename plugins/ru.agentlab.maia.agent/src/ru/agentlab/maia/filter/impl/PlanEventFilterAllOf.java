package ru.agentlab.maia.filter.impl;

import static java.util.stream.Collectors.joining;

import java.util.Collection;
import java.util.Map;

import ru.agentlab.maia.filter.IPlanEventFilter;

public class PlanEventFilterAllOf<T> implements IPlanEventFilter<T> {

	Collection<IPlanEventFilter<T>> matchers;

	public PlanEventFilterAllOf(Collection<IPlanEventFilter<T>> matchers) {
		this.matchers = matchers;
	}

	@Override
	public boolean matches(Object event, Map<String, Object> values) {
		for (IPlanEventFilter<T> matcher : matchers) {
			if (!matcher.matches(event, values)) {
				return false;
			}
		}
		return true;
	}

	@Override
	public String toString() {
		return "all of: " + matchers.stream().map(Object::toString).collect(joining(", ", "(", ")"));
	}

}
