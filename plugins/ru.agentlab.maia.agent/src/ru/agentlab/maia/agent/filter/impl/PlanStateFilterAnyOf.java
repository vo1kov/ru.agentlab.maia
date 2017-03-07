package ru.agentlab.maia.agent.filter.impl;

import static java.util.stream.Collectors.joining;

import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

import ru.agentlab.maia.agent.filter.IPlanStateFilter;

public class PlanStateFilterAnyOf implements IPlanStateFilter {

	IPlanStateFilter[] matchers;

	public PlanStateFilterAnyOf(Collection<IPlanStateFilter> matchers) {
		this.matchers = matchers.toArray(new IPlanStateFilter[matchers.size()]);
	}

	public PlanStateFilterAnyOf(IPlanStateFilter... matchers) {
		this.matchers = matchers;
	}

	@Override
	public boolean matches(Object item, Map<String, Object> values) {
		for (IPlanStateFilter matcher : matchers) {
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
