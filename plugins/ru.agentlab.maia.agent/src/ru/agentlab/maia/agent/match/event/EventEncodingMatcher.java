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

public class EventEncodingMatcher implements IEventMatcher<IMessage> {

	String encoding;

	public EventEncodingMatcher(String encoding) {
		this.encoding = encoding;
	}

	@Override
	public boolean match(IMessage message) {
		return message.getEncoding().equalsIgnoreCase(encoding);
	}

}
