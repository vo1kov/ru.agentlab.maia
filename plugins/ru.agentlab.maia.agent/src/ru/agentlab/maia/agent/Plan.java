/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Map;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IRolePlan;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.exception.PlanExecutionException;
import ru.agentlab.maia.IMatcher;

public class Plan implements IRolePlan {

	Object role;

	Method method;

	IMatcher<?> eventMatcher;

	IMatcher<?> stateMatchers;

	public Plan(Object object, Method method) {
		super();
		this.role = object;
		this.method = method;
	}

	public IMatcher<?> getEventMatcher() {
		return eventMatcher;
	}

	public void setEventMatcher(IMatcher<?> eventMatcher) {
		this.eventMatcher = eventMatcher;
	}

	public IMatcher<?> getStateMatcher() {
		return stateMatchers;
	}

	public void setStateMatcher(IMatcher<?> matcher) {
		this.stateMatchers = matcher;
	}

	@Override
	public Object execute() throws PlanExecutionException {
		try {
			return method.invoke(role);
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			throw new PlanExecutionException(e);
		}
	}

	@Override
	public Object getRole() {
		return role;
	}

	@Override
	public Method getMethod() {
		return method;
	}

	@Override
	public boolean relevant(IEvent<?> event, Map<String, Object> map) {
		Object eventData = event.getPayload();
		return match(eventMatcher, eventData, map);
	}

	private <M> boolean match(IMatcher<M> matcher, Object eventData, Map<String, Object> map) {
		Class<M> eventMatcherClass = matcher.getType();
		if (eventMatcherClass.isAssignableFrom(eventData.getClass())) {
			return matcher.match(eventMatcherClass.cast(eventData), map);
		} else {
			return false;
		}
	}

}
