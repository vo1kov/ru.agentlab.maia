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
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.UUID;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.Future;
import java.util.concurrent.RecursiveAction;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.AgentState;
import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IConverter;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.IRole;
import ru.agentlab.maia.IRoleBase;
import ru.agentlab.maia.event.PlanFailedEvent;
import ru.agentlab.maia.event.PlanFinishedEvent;
import ru.agentlab.maia.event.RoleResolvedEvent;
import ru.agentlab.maia.event.RoleUnresolvedEvent;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.ConverterException;
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

	protected final Queue<IMessage> messageQueue = new ConcurrentLinkedQueue<>();

	protected final Queue<IEvent<?>> eventQueue = new LinkedList<>();

	protected final IBeliefBase beliefBase = new BeliefBase(eventQueue, uuid.toString());

	protected final IGoalBase goalBase = new GoalBase(eventQueue);

	protected final IPlanBase planBase = new PlanBase(eventQueue);

	protected final IRoleBase roleBase = new RoleBase(eventQueue);

	IConverter converter;

	@Override
	public void start() {
		state = AgentState.ACTIVE;
		executor.submit(new ExecuteAction());
	}

	@Override
	public void stop() {
		state = AgentState.STOPPING;
	}

	@Override
	public void send(IMessage message) {
		messageQueue.offer(message);
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

	@Override
	public void deployTo(IContainer container) throws InjectorException, ContainerException {
		container.getInjector().inject(this);
		container.put(uuid.toString(), this);
		state = AgentState.IDLE;
	}

	@Override
	public Object addRole(Class<?> roleClass, Map<String, Object> parameters) throws ResolveException {
		switch (state) {
		case UNKNOWN:
			throw new IllegalStateException("Agent should be deployed into container before adding new roles.");
		case ACTIVE:
		case WAITING:
			throw new IllegalStateException("Agent is in ACTIVE state, use submit method instead.");
		case TRANSIT:
			throw new IllegalStateException("Agent is in TRANSIT state, can't add new roles.");
		case STOPPING:
			throw new IllegalStateException("Agent is in STOPPING state, can't add new roles.");
		case IDLE:
		default:
			return internalAddRole(roleClass, parameters);
		}
	}

	public Future<Object> submitRole(Class<?> roleClass, Map<String, Object> parameters) {
		return null;
	}

	protected Object internalAddRole(Class<?> roleClass, Map<String, Object> parameters) throws ResolveException {
		try {
			// Create instance of role object
			IInjector injector = container.getInjector();
			Object roleObject = injector.make(roleClass);
			injector.inject(roleObject);
			injector.invoke(roleObject, PostConstruct.class);

			// Now role object have resolved all field dependencies. Need to
			// convert role object to initial beliefs, goals and plans.
			List<OWLAxiom> initialBeliefs = converter.getInitialBeliefs(roleObject);
			List<OWLAxiom> initialGoals = converter.getInitialGoals(roleObject);
			Map<IPlan, EventType> initialPlans = converter.getPlans(roleObject);

			// If no exceptions was thrown by this moment then we can add
			// beliefs, goals and plans converted from role object and
			// role object themselves
			if (initialBeliefs != null) {
				beliefBase.addAxioms(initialBeliefs);
			}
			if (initialGoals != null) {
				goalBase.addAxioms(initialGoals);
			}
			if (initialPlans != null) {
				initialPlans.forEach((plan, type) -> planBase.add(type, plan));
			}

			// Add role object to the role base and generate event about
			// successful resolving
			roleBase.addRole(roleObject);
			eventQueue.offer(new RoleResolvedEvent(roleObject));
			return roleObject;
		} catch (InjectorException | ContainerException | ConverterException e) {
			eventQueue.offer(new RoleUnresolvedEvent(roleClass));
			throw new ResolveException(e);
		}
	}

	protected Collection<IPlan> getRolePlans() {
		return null;
	}

	protected class ExecuteAction extends RecursiveAction {

		private static final long serialVersionUID = 1L;

		@Override
		protected void compute() {
			IEvent<?> event = selectEvent();
			if (event == null) {
				state = AgentState.WAITING;
				return;
			}
			List<Plan> relevantPlans = selectRelevantPlans(event);
			List<Plan> applicablePlans = selectApplicablePlans(relevantPlans);
			applicablePlans.forEach(plan -> {
				try {
					plan.execute();
					eventQueue.offer(new PlanFinishedEvent(plan.getMethod()));
				} catch (Exception e) {
					eventQueue.offer(new PlanFailedEvent(plan.getMethod()));
				}
			});

			if (getState() == AgentState.ACTIVE) {
				ExecuteAction action = new ExecuteAction();
				invokeAll(action);
			}
		}

		protected IEvent<?> selectEvent() {
			return eventQueue.poll();
		}

		protected List<Plan> selectRelevantPlans(IEvent<?> event) {
			return null;
		}

		protected List<Plan> selectApplicablePlans(List<Plan> relevantPlans) {
			return null;
		}

	}
}
