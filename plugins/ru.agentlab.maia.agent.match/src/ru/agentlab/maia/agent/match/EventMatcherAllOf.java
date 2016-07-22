package ru.agentlab.maia.agent.match;

import static java.util.stream.Collectors.*;

import java.util.Collection;
import java.util.Map;

import ru.agentlab.maia.IEventMatcher;

public class EventMatcherAllOf<T> implements IEventMatcher<T> {

	Collection<IEventMatcher<T>> matchers;

	public EventMatcherAllOf(Collection<IEventMatcher<T>> matchers) {
		this.matchers = matchers;
	}

	@Override
	public boolean matches(Object event, Map<String, Object> values) {
		for (IEventMatcher<T> matcher : matchers) {
			if (!matcher.matches(event, values)) {
				return false;
			}
		}
		return true;
	}

	@Override
	public String toString() {
		return "all of: " + matchers.stream().map(Object::toString).collect(joining(", ", "(", ")"));
	}

}
