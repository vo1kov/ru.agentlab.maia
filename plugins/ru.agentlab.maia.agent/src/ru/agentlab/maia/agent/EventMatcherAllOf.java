package ru.agentlab.maia.agent;

import java.util.Map;

import ru.agentlab.maia.IEventMatcher;

public class EventMatcherAllOf implements IEventMatcher {

	IEventMatcher[] matchers;

	public EventMatcherAllOf(IEventMatcher... matchers) {
		this.matchers = matchers;
	}

	@Override
	public boolean matches(Object event, Map<String, Object> values) {
		for (IEventMatcher matcher : matchers) {
			if (!matcher.matches(event, values)) {
				return false;
			}
		}
		return true;
	}

}
