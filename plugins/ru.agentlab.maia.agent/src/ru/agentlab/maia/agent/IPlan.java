/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import ru.agentlab.maia.filter.IPlanEventFilter;
import ru.agentlab.maia.filter.IPlanStateFilter;

public interface IPlan {

	IPlanBody getPlanBody();
	
	Object getRole();

	void setStateMatcher(IPlanStateFilter stateMatcher);

	IPlanStateFilter getStateMatcher();

	void setEventMatcher(IPlanEventFilter<?> eventMatcher);

	IPlanEventFilter<?> getEventMatcher();

}
