package ru.agentlab.maia.match;

import java.util.Collection;
import java.util.Map;

import ru.agentlab.maia.IEventMatcher;

public class EventMatcherAllOf implements IEventMatcher {

	IEventMatcher[] matchers;

	public EventMatcherAllOf(IEventMatcher... matchers) {
		this.matchers = matchers;
	}

	public EventMatcherAllOf(Collection<IEventMatcher> matchers) {
		this.matchers = matchers.toArray(new IEventMatcher[matchers.size()]);
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
