package ru.agentlab.maia.agent;

import java.util.Collection;

import ru.agentlab.maia.IStateMatcher;

public class StateMatchers {

	public static IStateMatcher allOf(IStateMatcher... matchers) {
		return new StateMatcherAllOf(matchers);
	}

	public static IStateMatcher allOf(Collection<IStateMatcher> matchers) {
		return new StateMatcherAllOf(matchers);
	}

	public static IStateMatcher anything() {
		return (event, variables) -> true;
	}

	public static IStateMatcher nothing() {
		return (event, variables) -> false;
	}

}
