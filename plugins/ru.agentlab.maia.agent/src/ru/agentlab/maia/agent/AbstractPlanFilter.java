package ru.agentlab.maia.agent;

import java.util.Map;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IPlanFilter;

public abstract class AbstractPlanFilter implements IPlanFilter {

	protected final Matcher<?> eventMatcher;
	protected final Map<String, Object> variables;

	public AbstractPlanFilter(Matcher<?> eventMatcher, Map<String, Object> variables) {
		this.eventMatcher = eventMatcher;
		this.variables = variables;
	}

	@Override
	public Map<String, Object> getVariables() {
		return variables;
	}

	public Matcher<?> getEventMatcher() {
		return eventMatcher;
	}

}