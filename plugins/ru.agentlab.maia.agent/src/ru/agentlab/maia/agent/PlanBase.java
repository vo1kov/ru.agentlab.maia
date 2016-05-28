/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.util.Collection;
import java.util.EnumMap;
import java.util.HashSet;
import java.util.Queue;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.IRolePlan;
import ru.agentlab.maia.event.PlanRemovedEvent;

public class PlanBase implements IPlanBase {

	protected final Queue<IEvent<?>> eventQueue;

	protected final EnumMap<EventType, Collection<IPlan>> plans = new EnumMap<>(EventType.class);

	public PlanBase(Queue<IEvent<?>> eventQueue) {
		this.eventQueue = eventQueue;
	}

	@Override
	public void add(EventType type, IPlan plan) {
		Collection<IPlan> eventPlans = plans.get(type);
		if (eventPlans == null) {
			eventPlans = new HashSet<IPlan>();
		}
		eventPlans.add(plan);
		// eventQueue.offer(new PlanAddedEvent(plan.getMethod()));
	}

	@Override
	public void remove(IRolePlan plan) {
		for (Collection<IPlan> collection : plans.values()) {
			if (collection != null) {
				if (collection.remove(plan)) {
					eventQueue.offer(new PlanRemovedEvent(plan.getMethod()));
					return;
				}
			}
		}
	}

	@Override
	public Stream<IPlan> getPlansStream() {
		return plans.values().stream().flatMap(list -> list.stream());
	}

	@Override
	public Collection<IPlan> getPlans() {
		return plans.values().stream().flatMap(Collection::stream).collect(Collectors.toList());
	}

}
