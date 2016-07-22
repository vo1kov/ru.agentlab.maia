package ru.agentlab.maia.agent.match;

import java.util.Collection;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IEventMatcher;

public class EventMatchers {

	public static <T> IEventMatcher<T> allOf(Collection<IEventMatcher<T>> matchers) {
		return new EventMatcherAllOf<T>(matchers);
	}

	public static <T> IEventMatcher<T> anyOf(Collection<IEventMatcher<T>> matchers) {
		return new EventMatcherAnyOf<T>(matchers);
	}

	public static <T> IEventMatcher<T> hamcrest(Matcher<T> matcher) {
		return new EventMatcherHamcrest<T>(matcher);
	}

	public static IEventMatcher<Object> var(String name) {
		return new EventMatcherVariable(name);
	}

	public static IEventMatcher<Object> anything() {
		return (event, variables) -> true;
	}

	public static IEventMatcher<Object> nothing() {
		return (event, variables) -> false;
	}

}
