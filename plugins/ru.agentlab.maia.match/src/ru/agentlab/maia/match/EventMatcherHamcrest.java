package ru.agentlab.maia.match;

import java.util.Map;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IEventMatcher;

public class EventMatcherHamcrest<T> implements IEventMatcher<T> {

	Matcher<?> matcher;

	public EventMatcherHamcrest(Matcher<T> matcher) {
		this.matcher = matcher;
	}

	@Override
	public boolean matches(Object event, Map<String, Object> values) {
		return matcher.matches(event);
	}

	@Override
	public String toString() {
		return matcher.toString();
	}

}
