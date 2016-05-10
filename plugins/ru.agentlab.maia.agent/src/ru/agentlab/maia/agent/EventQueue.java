/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IEventQueue;

public class EventQueue implements IEventQueue {

	private final Queue<IEvent> queue = new ConcurrentLinkedQueue<IEvent>();

	@Override
	public IEvent poll() {
		return queue.poll();
	}

	@Override
	public IEvent peek() {
		return queue.peek();
	}

	@Override
	public boolean offer(IEvent event) {
		return queue.offer(event);
	}
	
}
