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
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.Future;
import java.util.concurrent.RecursiveAction;
import java.util.concurrent.atomic.AtomicReference;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLOntology;

import com.google.common.collect.ImmutableSet;

import ru.agentlab.maia.AgentState;
import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IAgentContainer;
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
import ru.agentlab.maia.agent.converter.Converter;
import ru.agentlab.maia.container.Injector;
import ru.agentlab.maia.event.PlanFailedEvent;
import ru.agentlab.maia.event.PlanFinishedEvent;
import ru.agentlab.maia.event.RoleResolvedEvent;
import ru.agentlab.maia.event.RoleUnresolvedEvent;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.ConverterException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.ResolveException;
import ru.agentlab.maia.exception.ServiceNotFound;

/**
 * @author Dmitriy Shishkin
 */
public class Agent implements IAgent {

	protected final UUID uuid = UUID.randomUUID();

	@Inject
	protected ForkJoinPool executor;

	protected AgentState state = AgentState.UNKNOWN;
	
	protected final IAgentContainer agentContainer = new AgentContainer();

	protected final Queue<IMessage> messageQueue = new ConcurrentLinkedQueue<>();

	protected final Queue<IEvent<?>> eventQueue = new LinkedList<>();

	protected final IBeliefBase beliefBase = new BeliefBase(eventQueue, uuid.toString());

	protected final IGoalBase goalBase = new GoalBase(eventQueue);

	protected final IPlanBase planBase = new PlanBase(eventQueue, agentContainer);

	protected final IRoleBase roleBase = new RoleBase(eventQueue);

	protected IConverter converter = new Converter();

	public IInjector getInjector() {
		return agentContainer.getInjector();
	}

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
		return agentContainer.getParent();
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
		agentContainer.setParent(container);
		state = AgentState.IDLE;
	}

	@Override
	public Object addRole(Class<?> roleClass, Map<String, Object> parameters) throws ResolveException {
		if (roleClass == null) {
			throw new NullPointerException("Role class can't be null");
		}
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
			IInjector injector = getInjector();
			Object roleObject = injector.make(roleClass);
			injector.inject(roleObject);
			injector.invoke(roleObject, PostConstruct.class, null);

			// Now role object have resolved all field dependencies. Need to
			// convert role object to initial beliefs, goals and plans.
			List<OWLAxiom> initialBeliefs = converter.getInitialBeliefs(roleObject);
			List<OWLAxiom> initialGoals = converter.getInitialGoals(roleObject);
			Map<IPlan, EventType> initialPlans = converter.getInitialPlans(roleObject, injector);

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

	protected final class AgentContainer implements IAgentContainer {
		@Inject
		protected final AtomicReference<IContainer> parent = new AtomicReference<IContainer>(null);
		final IInjector injector = new Injector(this);

		@Override
		public IContainer getParent() {
			return parent.get();
		}

		@Override
		public IInjector getInjector() {
			return injector;
		}

		@Override
		public IContainer setParent(IContainer parent) {
			return this.parent.getAndSet(parent);
		}

		@Override
		public UUID getUuid() {
			return uuid;
		}

		@Override
		public Object getLocal(String key) throws ServiceNotFound {
			if (key.equals(UUID.class.getName())) {
				return uuid;
			} else if (key.equals(IAgent.class.getName())) {
				return this;
			} else if (key.equals(IContainer.class.getName())) {
				return getParent();
			} else if (key.equals(IBeliefBase.class.getName())) {
				return beliefBase;
			} else if (key.equals(IGoalBase.class.getName())) {
				return goalBase;
			} else if (key.equals(IPlanBase.class.getName())) {
				return planBase;
			} else if (key.equals(IRoleBase.class.getName())) {
				return roleBase;
			} else if (key.equals(IRI.class.getName())) {
				return beliefBase.getOntologyIRI();
			} else if (key.equals(OWLOntology.class.getName())) {
				return beliefBase.getOntology();
			} else if (key.equals(OWLDataFactory.class.getName())) {
				return beliefBase.getFactory();
			} else {
				return null;
			}
		}

		public <T> T get(Class<T> key) throws ServiceNotFound {
			if (key == UUID.class) {
				return key.cast(uuid);
			} else if (key == IAgent.class) {
				return key.cast(this);
			} else if (key == IContainer.class) {
				return key.cast(getParent());
			} else if (key == IBeliefBase.class) {
				return key.cast(beliefBase);
			} else if (key == IGoalBase.class) {
				return key.cast(goalBase);
			} else if (key == IPlanBase.class) {
				return key.cast(planBase);
			} else if (key == IRoleBase.class) {
				return key.cast(roleBase);
			} else if (key == IRI.class) {
				return key.cast(beliefBase.getOntologyIRI());
			} else if (key == OWLOntology.class) {
				return key.cast(beliefBase.getOntology());
			} else if (key == OWLDataFactory.class) {
				return key.cast(beliefBase.getFactory());
			} else {
				return null;
			}
		}

		@Override
		public Set<String> getKeySet() {
			return ImmutableSet.of(
				// @formatter:off
				UUID.class.getName(),
				IAgent.class.getName(),
				IContainer.class.getName(),
				IBeliefBase.class.getName(),
				IGoalBase.class.getName(),
				IPlanBase.class.getName(),
				IRoleBase.class.getName(),
				IRI.class.getName(),
				OWLOntology.class.getName(),
				OWLDataFactory.class.getName()
				// @formatter:on
			);
		}
	}

	protected final class ExecuteAction extends RecursiveAction {

		private static final long serialVersionUID = 1L;

		@Override
		protected void compute() {
			IEvent<?> event = selectEvent();
			if (event == null) {
				state = AgentState.WAITING;
				return;
			}
			List<PlanStateful> relevantPlans = selectRelevantPlans(event);
			List<PlanStateful> applicablePlans = selectApplicablePlans(relevantPlans);
			applicablePlans.forEach(plan -> {
				try {
					plan.execute();
					eventQueue.offer(new PlanFinishedEvent(plan));
				} catch (Exception e) {
					eventQueue.offer(new PlanFailedEvent(plan));
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

		protected List<PlanStateful> selectRelevantPlans(IEvent<?> event) {
			return null;
		}

		protected List<PlanStateful> selectApplicablePlans(List<PlanStateful> relevantPlans) {
			return null;
		}

	}
}
