package ru.agentlab.maia.agent;

import java.util.Map;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IMatcher;
import ru.agentlab.maia.IPlan;

public abstract class Plan implements IPlan {

	protected IMatcher<?> eventMatcher;

	protected IMatcher<?> stateMatchers;

	protected final Object role;

	public Plan(Object role) {
		this.role = role;
	}

	@Override
	public IMatcher<?> getEventMatcher() {
		return eventMatcher;
	}

	@Override
	public void setEventMatcher(IMatcher<?> eventMatcher) {
		this.eventMatcher = eventMatcher;
	}

	@Override
	public IMatcher<?> getStateMatcher() {
		return stateMatchers;
	}

	@Override
	public void setStateMatcher(IMatcher<?> matcher) {
		this.stateMatchers = matcher;
	}

	@Override
	public boolean relevant(IEvent<?> event, Map<String, Object> map) {
		Object eventData = event.getPayload();
		return match(eventMatcher, eventData, map);
	}

	private <M> boolean match(IMatcher<M> matcher, Object eventData, Map<String, Object> map) {
		Class<M> eventMatcherClass = matcher.getType();
		if (eventMatcherClass.isAssignableFrom(eventData.getClass())) {
			return matcher.match(eventMatcherClass.cast(eventData), map);
		} else {
			return false;
		}
	}

}