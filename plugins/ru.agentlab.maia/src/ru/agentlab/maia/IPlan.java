/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import java.util.Map;

/**
 * @param <T>
 *            event type
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
public interface IPlan<T> {

	// IPlanBody getPlanBody();
	//
	// Object getRole();
	//
	// void setStateMatcher(IPlanStateFilter stateMatcher);
	//
	// IPlanStateFilter getStateMatcher();
	//
	// void setEventMatcher(IPlanEventFilter<?> eventMatcher);
	//
	// IPlanEventFilter<?> getEventMatcher();

	Class<T> getType();

	boolean unify(Object event, Map<String, Object> variables);

	void execute(IInjector injector, Map<String, Object> variables) throws Exception;

}
