/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.match.event;

import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.agent.IEventMatcher;

public class EventPerformativeMatcher implements IEventMatcher<IMessage> {

	String performative;

	public EventPerformativeMatcher(String performative) {
		this.performative = performative;
	}

	@Override
	public boolean match(IMessage message) {
		return message.getPerformative().equalsIgnoreCase(performative);
	}

}
