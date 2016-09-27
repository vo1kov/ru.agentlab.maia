package ru.agentlab.maia.agent.impl;

import java.lang.reflect.Method;
import java.util.Map;
import java.util.Objects;

import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.agent.IPlanBody;
import ru.agentlab.maia.container.IInjector;
import ru.agentlab.maia.filter.IPlanEventFilter;
import ru.agentlab.maia.filter.IPlanStateFilter;
import ru.agentlab.maia.filter.impl.PlanEventFilters;
import ru.agentlab.maia.filter.impl.PlanStateFilters;

public class Plan<T> implements IPlan<T> {

	protected IPlanEventFilter<? super T> eventMatcher;

	protected IPlanStateFilter stateMatcher;

	protected final IPlanBody planBody;

	protected final Class<T> eventClass;

	public Plan(Class<T> eventClass, IPlanBody planBody, IPlanEventFilter<? super T> eventMatcher, IPlanStateFilter stateMatcher) {
		Objects.requireNonNull(eventClass);
		Objects.requireNonNull(planBody);
		Objects.requireNonNull(eventMatcher);
		Objects.requireNonNull(stateMatcher);
		this.eventClass = eventClass;
		this.planBody = planBody;
		this.eventMatcher = eventMatcher;
		this.stateMatcher = stateMatcher;
	}

	public Plan(Class<T> eventClass, Object roleObject, Method method, IPlanEventFilter<? super T> eventMatcher, IPlanStateFilter stateMatcher) {
		this(eventClass, getPlanBody(roleObject, method), eventMatcher, stateMatcher);
	}

	public Plan(Class<T> eventClass, Object roleObject, Method method, IPlanEventFilter<? super T> eventMatcher) {
		this(eventClass, getPlanBody(roleObject, method), eventMatcher, PlanStateFilters.anything());
	}

	public Plan(Class<T> eventClass, Object roleObject, Method method, IPlanStateFilter stateMatcher) {
		this(eventClass, getPlanBody(roleObject, method), PlanEventFilters.anything(), stateMatcher);
	}

	public Plan(Class<T> eventClass, Object roleObject, Method method) {
		this(eventClass, getPlanBody(roleObject, method), PlanEventFilters.anything(), PlanStateFilters.anything());
	}

	public Plan(Class<T> eventClass, Runnable lambda, IPlanEventFilter<T> eventMatcher, IPlanStateFilter stateMatcher) {
		this(eventClass, new PlanBodyLambda(lambda), eventMatcher, stateMatcher);
	}

	public Plan(Class<T> eventClass, Runnable lambda, IPlanEventFilter<T> eventMatcher) {
		this(eventClass, new PlanBodyLambda(lambda), eventMatcher, PlanStateFilters.anything());
	}

	public Plan(Class<T> eventClass, Runnable lambda, IPlanStateFilter stateMatcher) {
		this(eventClass, new PlanBodyLambda(lambda), PlanEventFilters.anything(), stateMatcher);
	}

	public Plan(Class<T> eventClass, Runnable lambda) {
		this(eventClass, new PlanBodyLambda(lambda), PlanEventFilters.anything(), PlanStateFilters.anything());
	}

	public static IPlanBody getPlanBody(Object roleObject, Method method) {
		if (method.getParameterCount() == 0) {
			return new PlanBodyStateles(roleObject, method);
		} else {
			return new PlanBodyStateful(roleObject, method);
		}
	}

	// @Override
	// public IPlanBody getPlanBody() {
	// return planBody;
	// }
	//
	// @Override
	// public Object getRole() {
	// return role;
	// }

	// @Override
	// public IPlanEventFilter<?> getEventMatcher() {
	// return eventMatcher;
	// }
	//
	// @Override
	// public void setEventMatcher(IPlanEventFilter<?> eventMatcher) {
	// Objects.requireNonNull(eventMatcher);
	// this.eventMatcher = eventMatcher;
	// }
	//
	// @Override
	// public IPlanStateFilter getStateMatcher() {
	// return stateMatcher;
	// }
	//
	// @Override
	// public void setStateMatcher(IPlanStateFilter stateMatcher) {
	// Objects.requireNonNull(stateMatcher);
	// this.stateMatcher = stateMatcher;
	// }

	@Override
	public Class<T> getType() {
		return eventClass;
	}

	@Override
	public boolean unify(Object event, Map<String, Object> variables) {
//		return collection.stream().map(plan -> {
//
//			IPlanEventFilter<?> eventMatcher = plan.getEventMatcher();
//			IPlanStateFilter stateMatcher = plan.getStateMatcher();
//			if (eventMatcher.matches(event, variables) && stateMatcher.matches(event, variables)) {
//				return new Option(plan.getPlanBody(), variables);
//			} else {
//				return null;
//			}
//		}).filter(Objects::nonNull);
		return eventMatcher.matches(event, variables) && stateMatcher.matches(event, variables);
	}

	@Override
	public void execute(IInjector injector, Map<String, Object> variables) throws Exception {
		planBody.execute(injector, variables);
	}

}