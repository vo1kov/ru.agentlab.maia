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
import java.util.List;
import java.util.Queue;
import java.util.stream.Stream;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.IPlanFilter;
import ru.agentlab.maia.Option;

public class PlanBase implements IPlanBase {

	protected final Queue<IEvent<?>> eventQueue;

	protected final Multimap<Class<?>, IPlan> plans = ArrayListMultimap.create();

	public PlanBase(Queue<IEvent<?>> eventQueue) {
		this.eventQueue = eventQueue;
	}

	@Override
	public void add(Class<?> type, IPlan plan) {
		plans.put(type, plan);
	}

	@Override
	public void remove(Class<?> type, IPlan plan) {
		plans.remove(type, plan);
	}

	@Override
	public Iterable<Option> getOptions(IEvent<?> event) {
		Collection<IPlan> eventPlans = plans.get(event.getClass());
		List<Option> result = new ArrayList<>();
		Object eventData = event.getPayload();
		for (IPlan plan : eventPlans) {
			IPlanFilter planFilter = plan.getPlanFilter();
			if (planFilter.matches(eventData)) {
				result.add(new Option(plan.getPlanBody(), planFilter.getVariables()));
			}
		}
		return result;
	}

	@Override
	public Stream<IPlan> getPlansStream() {
		return plans.values().stream();
	}

	@Override
	public Collection<IPlan> getPlans() {
		return plans.values();
	}

}
