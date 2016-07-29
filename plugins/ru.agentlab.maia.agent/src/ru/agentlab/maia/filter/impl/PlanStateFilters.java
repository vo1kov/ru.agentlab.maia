package ru.agentlab.maia.filter.impl;

import java.util.Collection;

import ru.agentlab.maia.filter.IPlanStateFilter;

public class PlanStateFilters {

	public static IPlanStateFilter allOf(Collection<IPlanStateFilter> matchers) {
		return new PlanStateFilterAllOf(matchers);
	}

	public static IPlanStateFilter anyOf(Collection<IPlanStateFilter> matchers) {
		return new PlanStateFilterAnyOf(matchers);
	}

	public static IPlanStateFilter anything() {
		return (event, variables) -> true;
	}

	public static IPlanStateFilter nothing() {
		return (event, variables) -> false;
	}

}
