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

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.exception.PlanExecutionException;

public class Plan implements IPlan {

	Object role;

	Method method;

	IAgent agent;

	IMatcher<?> eventMatcher;

	IMatcher<?> stateMatchers;

	public Plan() {
		super();
	}

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
	public Method getMethod() {
		return method;
	}

	@Override
	public boolean isRelevant(IEvent<?> event) {
		return eventMatcher.match(event.getPayload());
	}

	@Override
	public boolean isApplicable() {
		stateMatchers.match(object);
		return true;
	}

}
