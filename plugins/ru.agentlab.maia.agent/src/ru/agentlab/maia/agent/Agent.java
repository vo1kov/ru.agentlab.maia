/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.util.List;
import java.util.UUID;
import java.util.concurrent.ForkJoinPool;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.AgentState;
import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IEventQueue;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.IMessageQueue;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.IRole;
import ru.agentlab.maia.IRoleBase;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.ResolveException;

/**
 * @author Dmitriy Shishkin
 */
public class Agent implements IAgent {

	protected final UUID uuid = UUID.randomUUID();

	@Inject
	protected ForkJoinPool executor;

	@Inject
	protected IContainer container;

	protected AgentState state = AgentState.UNKNOWN;

	protected IBeliefBase beliefBase;

	protected IGoalBase goalBase;

	protected IPlanBase planBase;

	protected IEventQueue eventQueue;

	protected IMessageQueue messageQueue;

	protected IRoleBase roleBase;

	@PostConstruct
	public void setup() {
		// final PlanExtractor extractor = new PlanExtractor();
		// contributors.stream().map(object -> extractor.extract(object));
	}

	public void addContributor(Class<?> clazz) throws InjectorException, ContainerException {
		IInjector injector = container.getInjector();
		Object contributor = injector.make(clazz);
		injector.inject(contributor);

	}

	@Override
	public void start() {
		state = AgentState.ACTIVE;
		executor.submit(new PoolAction(this));
	}

	@Override
	public void stop() {
		state = AgentState.SUSPENDED;
	}

	@Override
	public IContainer getContainer() {
		return container;
	}

	@Override
	public List<IRole> getRoles() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub");
	}

	@Override
	public AgentState getState() {
		return state;
	}

	@Override
	public UUID getUuid() {
		return uuid;
	}

	protected IEvent selectEvent() {
		return eventQueue.poll();
	}

	protected List<Plan> selectRelevantPlans(IEvent event) {
		return null;
	}

	protected List<Plan> selectApplicablePlans(List<Plan> relevantPlans) {
		return null;
	}

	@Override
	public void deployTo(IContainer container) {
		container.put(uuid.toString(), this);
		this.container = container;
	}

	@Override
	public void addRole(Class<?> role) {
		roleBase.addRole(role);
	}

	@Override
	public void resolve() throws ResolveException {
		roleBase.resolve();
	}
}
