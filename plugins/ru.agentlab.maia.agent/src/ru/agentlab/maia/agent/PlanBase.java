/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.agent.event.PlanAddedEvent;
import ru.agentlab.maia.agent.event.PlanRemovedEvent;

public class PlanBase implements IPlanBase {

	protected final Map<Class<? extends IEvent<?>>, List<IPlan>> plans = new HashMap<>();

	protected final Queue<IEvent<?>> eventQueue;

	public PlanBase(Queue<IEvent<?>> eventQueue) {
		this.eventQueue = eventQueue;
	}

	@Override
	public void add(IPlan plan) {
		Class<? extends IEvent<?>> type = plan.getEventType();
		List<IPlan> eventPlans = plans.get(type);
		if (eventPlans == null) {
			eventPlans = new ArrayList<IPlan>();
		}
		eventPlans.add(plan);
		eventQueue.offer(new PlanAddedEvent(plan));
	}

	@Override
	public void remove(IPlan plan) {
		List<IPlan> eventPlans = plans.get(plan.getEventType());
		eventPlans.remove(plan);
		eventQueue.offer(new PlanRemovedEvent(plan));
	}

}
