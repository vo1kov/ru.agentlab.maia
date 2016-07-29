package ru.agentlab.maia.filter.impl;

import java.util.Collection;

import org.hamcrest.Matcher;

import ru.agentlab.maia.filter.IPlanEventFilter;

public class PlanEventFilters {

	public static <T> IPlanEventFilter<T> allOf(Collection<IPlanEventFilter<T>> matchers) {
		return new PlanEventFilterAllOf<T>(matchers);
	}

	public static <T> IPlanEventFilter<T> anyOf(Collection<IPlanEventFilter<T>> matchers) {
		return new PlanEventFilterAnyOf<T>(matchers);
	}

	public static <T> IPlanEventFilter<T> hamcrest(Matcher<T> matcher) {
		return new PlanEventFilterHamcrest<T>(matcher);
	}

	public static IPlanEventFilter<Object> var(String name) {
		return new PlanEventFilterVariable(name);
	}

	public static IPlanEventFilter<Object> anything() {
		return (event, variables) -> true;
	}

	public static IPlanEventFilter<Object> nothing() {
		return (event, variables) -> false;
	}

}
