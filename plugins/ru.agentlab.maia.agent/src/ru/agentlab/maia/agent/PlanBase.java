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
import java.util.Collection;
import java.util.EnumMap;
import java.util.List;
import java.util.Queue;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.event.PlanAddedEvent;
import ru.agentlab.maia.event.PlanRemovedEvent;

public class PlanBase implements IPlanBase {

	protected final Queue<IEvent<?>> eventQueue;

	EnumMap<EventType, List<IPlan>> plans = new EnumMap<>(EventType.class);

	public PlanBase(Queue<IEvent<?>> eventQueue) {
		this.eventQueue = eventQueue;
	}

	@Override
	public void add(EventType type, IPlan plan) {
		List<IPlan> eventPlans = plans.get(type);
		if (eventPlans == null) {
			eventPlans = new ArrayList<IPlan>();
		}
		eventPlans.add(plan);
		eventQueue.offer(new PlanAddedEvent(plan.getMethod()));
	}

	@Override
	public void remove(IPlan plan) {
		List<IPlan> eventPlans = plans.get(plan.getEventType());
		eventPlans.remove(plan);
		eventQueue.offer(new PlanRemovedEvent(plan.getMethod()));
	}

	@Override
	public Stream<IPlan> getAllPlansStream() {
		return plans.values().stream().flatMap(list -> list.stream());
	}

	@Override
	public List<IPlan> getAllPlans() {
		return plans.values().stream().flatMap(Collection::stream).collect(Collectors.toList());
	}

}
