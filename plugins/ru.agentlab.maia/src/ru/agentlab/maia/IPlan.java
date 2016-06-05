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

import org.hamcrest.Matcher;

public interface IPlan {

	void setStateMatcher(Matcher<?> matcher);

	Matcher<?> getStateMatcher();

	void setEventMatcher(Matcher<?> eventMatcher);

	Matcher<?> getEventMatcher();

	boolean isRelevant(Object eventData);

	Map<String, Object> getVariables(Object eventData);

	boolean isApplicable(Map<String, Object> variables);

}
