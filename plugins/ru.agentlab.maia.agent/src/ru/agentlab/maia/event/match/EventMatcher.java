/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.event.match;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IEventMatch;
import ru.agentlab.maia.IEventMatcher;

public class EventMatcher implements IEventMatcher {

	String object;

	String predicate;

	String subject;
	
	public EventMatcher(String object, String predicate, String subject) {
		this.object = object;
		this.predicate = predicate;
		this.subject = subject;
	}

	@Override
	public IEventMatch match(IEvent event) {
		return null;
	}

}
