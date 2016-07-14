package ru.agentlab.maia.agent;

import java.util.Map;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IPlanFilter;
import ru.agentlab.maia.IStateMatcher;

public class PlanFilterFactory {

	public static IPlanFilter create(Matcher<?> eventMatcher, Map<String, Object> variables) {
		return new PlanFilterStateles(eventMatcher, variables);
	}

	public static IPlanFilter create(Matcher<?> eventMatcher, Map<String, Object> variables,
			IStateMatcher stateMatcher) {
		if (stateMatcher != null) {
			return new PlanFilterStateful(eventMatcher, variables, stateMatcher);
		} else {
			return create(eventMatcher, variables);
		}
	}

}
