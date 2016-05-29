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

import ru.agentlab.maia.exception.PlanExecutionException;

public interface IPlan {

	Object execute() throws PlanExecutionException;

	boolean relevant(IEvent<?> event, Map<String, Object> map);

	void setStateMatcher(IMatcher<?> matcher);

	IMatcher<?> getStateMatcher();

	void setEventMatcher(IMatcher<?> eventMatcher);

	IMatcher<?> getEventMatcher();

}
