package ru.agentlab.maia.agent;

import java.util.Map;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBody;
import ru.agentlab.maia.IPlanFilter;

public abstract class Plan implements IPlan {
	
	IPlanFilter planFilter;
	
	IPlanBody planBody;

	protected Matcher<?> eventMatcher;

	protected Matcher<?> stateMatchers;

	protected final Object role;

	public Plan(Object role) {
		this.role = role;
	}

	@Override
	public boolean isRelevant(Object eventData) {
		return eventMatcher.matches(eventData);
	}

	@Override
	public boolean isApplicable(Map<String, Object> variables) {
		return false;
	}

	@Override
	public Map<String, Object> getVariables(Object eventData) {
		return null;
	}

	@Override
	public Matcher<?> getEventMatcher() {
		return eventMatcher;
	}

	@Override
	public void setEventMatcher(Matcher<?> eventMatcher) {
		this.eventMatcher = eventMatcher;
	}

	@Override
	public Matcher<?> getStateMatcher() {
		return stateMatchers;
	}

	@Override
	public void setStateMatcher(Matcher<?> matcher) {
		this.stateMatchers = matcher;
	}

}