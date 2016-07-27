package ru.agentlab.maia.filter.impl;

import static java.util.stream.Collectors.joining;

import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

import ru.agentlab.maia.filter.IPlanStateFilter;

public class PlanStateFilterAllOf implements IPlanStateFilter {

	IPlanStateFilter[] matchers;

	public PlanStateFilterAllOf(Collection<IPlanStateFilter> matchers) {
		this.matchers = matchers.toArray(new IPlanStateFilter[matchers.size()]);
	}

	public PlanStateFilterAllOf(IPlanStateFilter... matchers) {
		this.matchers = matchers;
	}

	@Override
	public boolean matches(Object item, Map<String, Object> values) {
		for (IPlanStateFilter matcher : matchers) {
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
