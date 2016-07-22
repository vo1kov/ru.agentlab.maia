package ru.agentlab.maia.agent.match;

import static java.util.stream.Collectors.joining;

import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

import ru.agentlab.maia.IStateMatcher;

public class StateMatcherAnyOf implements IStateMatcher {

	IStateMatcher[] matchers;

	public StateMatcherAnyOf(Collection<IStateMatcher> matchers) {
		this.matchers = matchers.toArray(new IStateMatcher[matchers.size()]);
	}

	public StateMatcherAnyOf(IStateMatcher... matchers) {
		this.matchers = matchers;
	}

	@Override
	public boolean matches(Object item, Map<String, Object> values) {
		for (IStateMatcher matcher : matchers) {
			if (matcher.matches(item, values)) {
				return true;
			}
		}
		return false;
	}

	@Override
	public String toString() {
		return "anyof: " + Arrays.stream(matchers).map(Object::toString).collect(joining(", ", "(", ")"));
	}

}
