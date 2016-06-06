package ru.agentlab.maia.agent;

import java.util.HashMap;
import java.util.Map;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IPlanFilter;

public class PlanFilter implements IPlanFilter {

	private final Map<String, Object> values = new HashMap<>();

	protected final Matcher<?> eventMatcher;

	protected final IStateMatcher stateMatcher;

	public PlanFilter(Matcher<?> eventMatcher, IStateMatcher stateMatcher) {
		super();
		this.eventMatcher = eventMatcher;
		this.stateMatcher = stateMatcher;
	}

	@Override
	public boolean matches(Object item, Map<String, Object> values) {
		values.clear();
		return eventMatcher.matches(item) && stateMatcher.matches(item, values);
	}

	public Map<String, Object> getValues() {
		return values;
	}

	public Matcher<?> getEventMatcher() {
		return eventMatcher;
	}

	public IStateMatcher getStateMatcher() {
		return stateMatcher;
	}

}
