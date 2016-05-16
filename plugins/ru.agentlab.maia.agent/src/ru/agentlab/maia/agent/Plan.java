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
import java.util.List;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.exception.PlanExecutionException;

public class Plan implements IPlan {

	Object role;

	Method method;

	IAgent agent;

	IEventMatcher<?> eventMatcher;

	List<IStateMatcher> stateMatchers;

	public Plan() {
		super();
	}

	public Plan(Object object, Method method) {
		super();
		this.role = object;
		this.method = method;
	}

	public IEventMatcher<?> getEventMatcher() {
		return eventMatcher;
	}

	public void setEventMatcher(IEventMatcher<?> eventMatcher) {
		this.eventMatcher = eventMatcher;
	}

	public List<IStateMatcher> getStateMatchers() {
		return stateMatchers;
	}

	public void addStateMatcher(IStateMatcher matcher) {
		stateMatchers.add(matcher);
	}

	@Override
	public Object execute() throws PlanExecutionException {
		try {
			return method.invoke(role);
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			throw new PlanExecutionException(e);
		}
	}

	// @Override
	// public boolean isRelevant(IEvent event) {
	// return eventMatcher.match(event.getPayload());
	// }
	//
	// @Override
	// public boolean isApplicable() {
	// for (IStateMatcher stateMatcher : stateMatchers) {
	// if (stateMatcher.match(agent)) {
	// return false;
	// }
	// }
	// return true;
	// }

}
