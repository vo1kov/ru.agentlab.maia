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
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Queue;
import java.util.stream.Stream;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.IStateMatcher;
import ru.agentlab.maia.Option;
import ru.agentlab.maia.event.AgentStartedEvent;
import ru.agentlab.maia.event.AgentStoppedEvent;
import ru.agentlab.maia.event.ExternalAddedEvent;

public class PlanBase implements IPlanBase {

	protected final Queue<IEvent<?>> eventQueue;

	protected final Multimap<Class<?>, IPlan> plans = ArrayListMultimap.create();

	public PlanBase(Queue<IEvent<?>> eventQueue) {
		Objects.requireNonNull(eventQueue);
		this.eventQueue = eventQueue;
	}

	@Override
	public void add(Class<?> type, IPlan plan) {
		Objects.requireNonNull(type);
		Objects.requireNonNull(plan);
		plans.put(type, plan);
	}

	@Override
	public void addAll(Multimap<Class<?>, IPlan> map) {
		Objects.requireNonNull(map);
		plans.putAll(map);
	}

	@Override
	public void remove(Class<?> type, IPlan plan) {
		Objects.requireNonNull(type);
		Objects.requireNonNull(plan);
		plans.remove(type, plan);
	}

	@Override
	public Collection<IPlan> getStartPlans() {
		return plans.get(AgentStartedEvent.class);
	}

	@Override
	public Collection<IPlan> getStopPlans() {
		return plans.get(AgentStoppedEvent.class);
	}

	@Override
	public Stream<Option> getOptions(IEvent<?> event) {
		Objects.requireNonNull(event);
		Object payload = event.getPayload();
		Class<?> eventType = event.getClass();
		if (event instanceof ExternalAddedEvent) {
			eventType = event.getPayload().getClass();
		}
		Collection<IPlan> collection = plans.get(eventType);
		return collection.stream().map(plan -> {
			Map<String, Object> variables = new HashMap<>();
			IEventMatcher<?> eventMatcher = plan.getEventMatcher();
			IStateMatcher stateMatcher = plan.getStateMatcher();
			if (eventMatcher.matches(payload, variables) && stateMatcher.matches(payload, variables)) {
				return new Option(plan.getPlanBody(), variables);
			} else {
				return null;
			}
		}).filter(Objects::nonNull);
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
