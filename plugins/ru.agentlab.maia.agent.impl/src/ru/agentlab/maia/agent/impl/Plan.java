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

	protected final Class<T> roleClass;

	public Plan(Class<T> roleClass, IPlanBody planBody, IPlanEventFilter<? super T> eventMatcher, IPlanStateFilter stateMatcher) {
		Objects.requireNonNull(roleClass);
		Objects.requireNonNull(planBody);
		Objects.requireNonNull(eventMatcher);
		Objects.requireNonNull(stateMatcher);
		this.roleClass = roleClass;
		this.planBody = planBody;
		this.eventMatcher = eventMatcher;
		this.stateMatcher = stateMatcher;
	}

	public Plan(Class<T> roleClass, Method method, IPlanEventFilter<? super T> eventMatcher, IPlanStateFilter stateMatcher) {
		this(roleClass, getPlanBody(roleClass, method), eventMatcher, stateMatcher);
	}

	public Plan(Class<T> roleClass, Method method, IPlanEventFilter<? super T> eventMatcher) {
		this(roleClass, getPlanBody(roleClass, method), eventMatcher, PlanStateFilters.anything());
	}

	public Plan(Class<T> roleClass, Method method, IPlanStateFilter stateMatcher) {
		this(roleClass, getPlanBody(roleClass, method), PlanEventFilters.anything(), stateMatcher);
	}

	public Plan(Class<T> roleClass, Method method) {
		this(roleClass, getPlanBody(roleClass, method), PlanEventFilters.anything(), PlanStateFilters.anything());
	}

	public Plan(Class<T> roleClass, Runnable lambda, IPlanEventFilter<T> eventMatcher, IPlanStateFilter stateMatcher) {
		this(roleClass, new PlanBodyLambda(lambda), eventMatcher, stateMatcher);
	}

	public Plan(Class<T> roleClass, Runnable lambda, IPlanEventFilter<T> eventMatcher) {
		this(roleClass, new PlanBodyLambda(lambda), eventMatcher, PlanStateFilters.anything());
	}

	public Plan(Class<T> roleClass, Runnable lambda, IPlanStateFilter stateMatcher) {
		this(roleClass, new PlanBodyLambda(lambda), PlanEventFilters.anything(), stateMatcher);
	}

	public Plan(Class<T> roleClass, Runnable lambda) {
		this(roleClass, new PlanBodyLambda(lambda), PlanEventFilters.anything(), PlanStateFilters.anything());
	}

	public static IPlanBody getPlanBody(Object roleClass, Method method) {
		if (method.getParameterCount() == 0) {
			return new PlanBodyStateles(roleClass, method);
		} else {
			return new PlanBodyStateful(roleClass, method);
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
		return roleClass;
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