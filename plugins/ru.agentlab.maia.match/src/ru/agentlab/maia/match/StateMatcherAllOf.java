package ru.agentlab.maia.match;

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
	
}
