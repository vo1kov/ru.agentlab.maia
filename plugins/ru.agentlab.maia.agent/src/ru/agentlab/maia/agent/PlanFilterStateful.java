package ru.agentlab.maia.agent;

import java.util.Map;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IStateMatcher;

public class PlanFilterStateful extends AbstractPlanFilter {

	protected final IStateMatcher stateMatcher;

	public PlanFilterStateful(Matcher<?> eventMatcher, Map<String, Object> variables, IStateMatcher stateMatcher) {
		super(eventMatcher, variables);
		this.stateMatcher = stateMatcher;
	}

	@Override
	public boolean matches(Object item) {
		variables.clear();
		return eventMatcher.matches(item) && stateMatcher.matches(item, variables);
	}

	public IStateMatcher getStateMatcher() {
		return stateMatcher;
	}

}
