package ru.agentlab.maia.agent.match;

import static java.util.stream.Collectors.joining;

import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

import ru.agentlab.maia.IStateMatcher;

public class StateMatcherAllOf implements IStateMatcher {

	IStateMatcher[] matchers;

	public StateMatcherAllOf(Collection<IStateMatcher> matchers) {
		this.matchers = matchers.toArray(new IStateMatcher[matchers.size()]);
	}

	public StateMatcherAllOf(IStateMatcher... matchers) {
		this.matchers = matchers;
	}

	@Override
	public boolean matches(Object item, Map<String, Object> values) {
		for (IStateMatcher matcher : matchers) {
			if (!matcher.matches(item, values)) {
				return false;
			}
		}
		return true;
	}

	@Override
	public String toString() {
		return "all of: " + Arrays.stream(matchers).map(Object::toString).collect(joining(", ", "(", ")"));
	}

}