package ru.agentlab.maia.agent;

import java.util.Map;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IEvent;
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
	public boolean relevant(IEvent<?> event, Map<String, Object> map) {
		Object eventData = event.getPayload();
		return match(eventMatcher, eventData, map);
	}

	private <M> boolean match(Matcher<M> matcher, Object eventData, Map<String, Object> map) {
//		Class<M> eventMatcherClass = matcher.getType();
		if (eventMatcherClass.isAssignableFrom(eventData.getClass())) {
			return matcher.matches(eventMatcherClass.cast(eventData));
		} else {
			return false;
		}
	}

}