package ru.agentlab.maia.agent;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IPlan;

public abstract class Plan implements IPlan {

	protected Matcher<?> eventMatcher;

	protected Matcher<?> stateMatchers;

	protected final Object role;

	public Plan(Object role) {
		this.role = role;
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

	@Override
	public boolean isRelevant(Object eventData) {
		return eventMatcher.matches(eventData);
	}

}