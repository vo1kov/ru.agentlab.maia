package ru.agentlab.maia.agent.match;

import java.util.Collection;
import java.util.Map;

import ru.agentlab.maia.IStateMatcher;

public class CompositeStateMatcher implements IStateMatcher {

	IStateMatcher[] matchers;

	public CompositeStateMatcher(Collection<IStateMatcher> matchers) {
		this.matchers = matchers.toArray(new IStateMatcher[matchers.size()]);
	}

	public CompositeStateMatcher(IStateMatcher... matchers) {
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
