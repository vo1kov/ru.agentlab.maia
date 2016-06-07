package ru.agentlab.maia.agent;

import java.util.Map;

import org.hamcrest.Description;
import org.hamcrest.Matcher;

public class PlanFilterStateles extends AbstractPlanFilter {

	public PlanFilterStateles(Matcher<?> eventMatcher, Map<String, Object> variables) {
		super(eventMatcher, variables);
	}

	@Override
	public boolean matches(Object item) {
		variables.clear();
		boolean result = eventMatcher.matches(item);
		if (!result) {
			Description description = Description.NONE;
			eventMatcher.describeMismatch(item, description);
			System.out.println(description);
		}
		return result;
	}

}
