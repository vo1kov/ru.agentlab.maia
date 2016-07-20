package ru.agentlab.maia.agent;

import java.util.Map;

import ru.agentlab.maia.IEventMatcher;

public class EventMatcherAnyOf implements IEventMatcher {

	IEventMatcher[] matchers;

	public EventMatcherAnyOf(IEventMatcher... matchers) {
		this.matchers = matchers;
	}

	@Override
	public boolean matches(Object event, Map<String, Object> values) {
		for (IEventMatcher matcher : matchers) {
			if (matcher.matches(event, values)) {
				return true;
			}
		}
		return false;
	}

}
