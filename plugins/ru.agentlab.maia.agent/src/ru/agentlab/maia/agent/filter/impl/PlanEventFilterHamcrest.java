package ru.agentlab.maia.agent.filter.impl;

import java.util.Map;

import org.hamcrest.Matcher;

import ru.agentlab.maia.agent.filter.IPlanEventFilter;

public class PlanEventFilterHamcrest<T> implements IPlanEventFilter<T> {

	Matcher<?> matcher;

	public PlanEventFilterHamcrest(Matcher<T> matcher) {
		this.matcher = matcher;
	}

	@Override
	public boolean matches(Object event, Map<String, Object> values) {
		return matcher.matches(event);
	}

	@Override
	public String toString() {
		return matcher.toString();
	}

}
