package ru.agentlab.maia.agent.match;

import static java.util.stream.Collectors.joining;

import java.util.Collection;
import java.util.Map;

import ru.agentlab.maia.IEventMatcher;

public class EventMatcherAnyOf<T> implements IEventMatcher<T> {

	Collection<IEventMatcher<T>> matchers;

	public EventMatcherAnyOf(Collection<IEventMatcher<T>> matchers) {
		this.matchers = matchers;
	}

	@Override
	public boolean matches(Object event, Map<String, Object> values) {
		for (IEventMatcher<T> matcher : matchers) {
			if (matcher.matches(event, values)) {
				return true;
			}
		}
		return false;
	}

	@Override
	public String toString() {
		return "any of: " + matchers.stream().map(Object::toString).collect(joining(", ", "(", ")"));
	}

}
