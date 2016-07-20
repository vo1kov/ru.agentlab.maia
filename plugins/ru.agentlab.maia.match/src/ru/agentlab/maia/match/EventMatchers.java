package ru.agentlab.maia.match;

import java.util.Collection;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IEventMatcher;

public class EventMatchers {

	public static IEventMatcher allOf(IEventMatcher... matchers) {
		return new EventMatcherAllOf(matchers);
	}

	public static IEventMatcher allOf(Collection<IEventMatcher> matchers) {
		return new EventMatcherAllOf(matchers);
	}

	public static IEventMatcher anyOf(IEventMatcher... matchers) {
		return new EventMatcherAnyOf(matchers);
	}

	public static IEventMatcher anyOf(Collection<IEventMatcher> matchers) {
		return new EventMatcherAnyOf(matchers);
	}

	public static IEventMatcher hamcrest(Matcher<?> matcher) {
		return new EventMatcherHamcrest(matcher);
	}

	public static IEventMatcher var(String name) {
		return new EventMatcherVariable(name);
	}

	public static IEventMatcher anything() {
		return (event, variables) -> true;
	}

	public static IEventMatcher nothing() {
		return (event, variables) -> false;
	}

}
