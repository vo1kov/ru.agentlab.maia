package ru.agentlab.maia.agent.impl;

import java.lang.reflect.Method;
import java.util.Objects;

import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.agent.IPlanBody;
import ru.agentlab.maia.filter.IPlanEventFilter;
import ru.agentlab.maia.filter.IPlanStateFilter;
import ru.agentlab.maia.filter.impl.PlanEventFilters;
import ru.agentlab.maia.filter.impl.PlanStateFilters;

public class Plan implements IPlan {

	protected IPlanEventFilter<?> eventMatcher;

	protected IPlanStateFilter stateMatcher;

	protected final IPlanBody planBody;

	protected final Object role;

	public Plan(Object role, IPlanBody planBody, IPlanEventFilter<?> eventMatcher, IPlanStateFilter stateMatcher) {
		Objects.requireNonNull(role);
		Objects.requireNonNull(planBody);
		Objects.requireNonNull(eventMatcher);
		Objects.requireNonNull(stateMatcher);
		this.role = role;
		this.planBody = planBody;
		this.eventMatcher = eventMatcher;
		this.stateMatcher = stateMatcher;
	}

	public Plan(Object role, Method method, IPlanEventFilter<?> eventMatcher, IPlanStateFilter stateMatcher) {
		this(role, getPlanBody(role, method), eventMatcher, stateMatcher);
	}

	public Plan(Object role, Method method, IPlanEventFilter<?> eventMatcher) {
		this(role, getPlanBody(role, method), eventMatcher, PlanStateFilters.anything());
	}

	public Plan(Object role, Method method, IPlanStateFilter stateMatcher) {
		this(role, getPlanBody(role, method), PlanEventFilters.anything(), stateMatcher);
	}

	public Plan(Object role, Method method) {
		this(role, getPlanBody(role, method), PlanEventFilters.anything(), PlanStateFilters.anything());
	}

	public Plan(Object role, Runnable lambda, IPlanEventFilter<?> eventMatcher, IPlanStateFilter stateMatcher) {
		this(role, new PlanBodyLambda(lambda), eventMatcher, stateMatcher);
	}

	public Plan(Object role, Runnable lambda, IPlanEventFilter<?> eventMatcher) {
		this(role, new PlanBodyLambda(lambda), eventMatcher, PlanStateFilters.anything());
	}

	public Plan(Object role, Runnable lambda, IPlanStateFilter stateMatcher) {
		this(role, new PlanBodyLambda(lambda), PlanEventFilters.anything(), stateMatcher);
	}

	public Plan(Object role, Runnable lambda) {
		this(role, new PlanBodyLambda(lambda), PlanEventFilters.anything(), PlanStateFilters.anything());
	}

	public static IPlanBody getPlanBody(Object role, Method method) {
		if (method.getParameterCount() == 0) {
			return new PlanBodyStateles(role, method);
		} else {
			return new PlanBodyStateful(role, method);
		}
	}

	@Override
	public IPlanBody getPlanBody() {
		return planBody;
	}

	@Override
	public Object getRole() {
		return role;
	}

	@Override
	public IPlanEventFilter<?> getEventMatcher() {
		return eventMatcher;
	}

	@Override
	public void setEventMatcher(IPlanEventFilter<?> eventMatcher) {
		Objects.requireNonNull(eventMatcher);
		this.eventMatcher = eventMatcher;
	}

	@Override
	public IPlanStateFilter getStateMatcher() {
		return stateMatcher;
	}

	@Override
	public void setStateMatcher(IPlanStateFilter stateMatcher) {
		Objects.requireNonNull(stateMatcher);
		this.stateMatcher = stateMatcher;
	}

}