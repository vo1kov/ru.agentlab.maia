package ru.agentlab.maia.agent;

import java.lang.reflect.Method;
import java.util.Objects;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBody;
import ru.agentlab.maia.IStateMatcher;

public class Plan implements IPlan {

	protected IEventMatcher eventMatcher;

	protected IStateMatcher stateMatcher;

	protected final IPlanBody planBody;

	protected final Object role;

	public Plan(Object role, IPlanBody planBody, IEventMatcher eventMatcher, IStateMatcher stateMatcher) {
		Objects.requireNonNull(role);
		Objects.requireNonNull(planBody);
		Objects.requireNonNull(eventMatcher);
		Objects.requireNonNull(stateMatcher);
		this.role = role;
		this.planBody = planBody;
		this.eventMatcher = eventMatcher;
		this.stateMatcher = stateMatcher;
	}

	public Plan(Object role, Method method, IEventMatcher eventMatcher, IStateMatcher stateMatcher) {
		this(role, getPlanBody(role, method), eventMatcher, stateMatcher);
	}

	public Plan(Object role, Method method, IEventMatcher eventMatcher) {
		this(role, getPlanBody(role, method), eventMatcher, StateMatchers.anything());
	}

	public Plan(Object role, Method method, IStateMatcher stateMatcher) {
		this(role, getPlanBody(role, method), EventMatchers.anything(), stateMatcher);
	}

	public Plan(Object role, Method method) {
		this(role, getPlanBody(role, method), EventMatchers.anything(), StateMatchers.anything());
	}

	public Plan(Object role, Runnable lambda, IEventMatcher eventMatcher, IStateMatcher stateMatcher) {
		this(role, new PlanBodyLambda(lambda), eventMatcher, stateMatcher);
	}

	public Plan(Object role, Runnable lambda, IEventMatcher eventMatcher) {
		this(role, new PlanBodyLambda(lambda), eventMatcher, StateMatchers.anything());
	}

	public Plan(Object role, Runnable lambda, IStateMatcher stateMatcher) {
		this(role, new PlanBodyLambda(lambda), EventMatchers.anything(), stateMatcher);
	}

	public Plan(Object role, Runnable lambda) {
		this(role, new PlanBodyLambda(lambda), EventMatchers.anything(), StateMatchers.anything());
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
	public IEventMatcher getEventMatcher() {
		return eventMatcher;
	}

	@Override
	public void setEventMatcher(IEventMatcher eventMatcher) {
		Objects.requireNonNull(eventMatcher);
		this.eventMatcher = eventMatcher;
	}

	@Override
	public IStateMatcher getStateMatcher() {
		return stateMatcher;
	}

	@Override
	public void setStateMatcher(IStateMatcher stateMatcher) {
		Objects.requireNonNull(stateMatcher);
		this.stateMatcher = stateMatcher;
	}

}