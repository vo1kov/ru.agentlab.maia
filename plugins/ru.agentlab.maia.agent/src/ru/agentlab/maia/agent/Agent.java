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
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.Future;
import java.util.concurrent.RecursiveAction;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Stream;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLOntology;

import com.google.common.collect.ImmutableSet;

import de.derivo.sparqldlapi.QueryEngine;
import ru.agentlab.maia.AgentState;
import ru.agentlab.maia.ConvertWith;
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
import ru.agentlab.maia.Option;
import ru.agentlab.maia.container.Injector;
import ru.agentlab.maia.event.AddedRoleEvent;
import ru.agentlab.maia.event.RemovedRoleEvent;
import ru.agentlab.maia.event.ResolvedRoleEvent;
import ru.agentlab.maia.event.UnresolvedRoleEvent;
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

	protected AgentState state = AgentState.UNKNOWN;

	protected final AgentContainer agentContainer = new AgentContainer();

	protected final Queue<IMessage> messageQueue = new ConcurrentLinkedQueue<>();

	protected final Queue<IEvent<?>> eventQueue = new LinkedList<>();

	protected final IBeliefBase beliefBase = new BeliefBase();

	protected final IGoalBase goalBase = new GoalBase(eventQueue);

	protected final IPlanBase planBase = new PlanBase(eventQueue);

	protected final Set<Object> roles = new HashSet<>();

	@PostConstruct
	public void init() throws InjectorException {
		Map<String, Object> additional = new HashMap<>();
		additional.put(Queue.class.getName(), eventQueue);
		getInjector().inject(beliefBase, additional);
		getInjector().invoke(beliefBase, PostConstruct.class, null, additional);
	}

	public IInjector getInjector() {
		return agentContainer.injector;
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
	public Collection<Object> getRoles() {
		return roles;
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
		agentContainer.setParent(container);
		getInjector().inject(this);
		getInjector().invoke(this, PostConstruct.class);
		container.put(uuid.toString(), this);
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

	@Override
	public boolean removeRole(Object roleObject) {
		if (roleObject == null) {
			throw new NullPointerException("Role class can't be null");
		}
		switch (state) {
		case ACTIVE:
		case WAITING:
			throw new IllegalStateException("Agent is in ACTIVE state, use submit method instead.");
		case TRANSIT:
			throw new IllegalStateException("Agent is in TRANSIT state, can't remove roles.");
		case STOPPING:
			throw new IllegalStateException("Agent is in STOPPING state, can't remove roles.");
		case IDLE:
		case UNKNOWN:
		default:
			return internalRemoveRole(roleObject);
		}
	}

	@Override
	public boolean removeAllRoles() {
		switch (state) {
		case ACTIVE:
		case WAITING:
			throw new IllegalStateException("Agent is in ACTIVE state, use submit method instead.");
		case TRANSIT:
			throw new IllegalStateException("Agent is in TRANSIT state, can't remove roles.");
		case STOPPING:
			throw new IllegalStateException("Agent is in STOPPING state, can't remove roles.");
		case IDLE:
		case UNKNOWN:
		default:
			return internalRemoveAllRoles();
		}
	}

	@Override
	public Future<Object> submitAddRole(Class<?> roleClass, Map<String, Object> parameters) {
		return null;
	}

	@Override
	public Future<Boolean> submitRemoveRole(Object roleObject) {
		return null;
	}

	@Override
	public Future<Boolean> submitRemoveAllRoles() {
		return null;
	}

	protected boolean internalRemoveRole(Object roleObject) {
		boolean removed = roles.remove(roleObject);
		if (removed) {
			eventQueue.offer(new RemovedRoleEvent(roleObject));
		}
		return removed;
	}

	protected boolean internalRemoveAllRoles() {
		Stream<RemovedRoleEvent> events = roles.stream().map(role -> new RemovedRoleEvent(role));
		roles.clear();
		events.forEach(eventQueue::offer);
		return true;
	}

	protected Object internalAddRole(Class<?> roleClass, Map<String, Object> parameters) throws ResolveException {
		try {
			ConvertWith convertWith = roleClass.getAnnotation(ConvertWith.class);
			if (convertWith == null) {
				throw new ResolveException(
						"Unknown converter, use @" + ConvertWith.class.getName() + " to specify converter.");
			}
			// Create instance of role object
			IInjector injector = getInjector();
			Object roleObject = injector.make(roleClass, parameters);
			injector.inject(roleObject);
			injector.invoke(roleObject, PostConstruct.class, null, null);

			IConverter converter = injector.make(convertWith.value());
			injector.inject(converter);
			injector.invoke(converter, PostConstruct.class, null, null);
			// Now role object have resolved all field dependencies. Need to
			// convert role object to initial beliefs, goals and plans.
			Set<OWLAxiom> initialBeliefs = converter.getInitialBeliefs(roleObject);
			Set<OWLAxiom> initialGoals = converter.getInitialGoals(roleObject);
			Map<IPlan, EventType> initialPlans = converter.getInitialPlans(roleObject);

			// If no exceptions was thrown by this moment then we can add
			// beliefs, goals and plans converted from role object and
			// role object themselves
			beliefBase.addBeliefs(initialBeliefs);
			goalBase.addGoals(initialGoals);
			initialPlans.forEach((plan, type) -> planBase.add(type, plan));

			// Add role object to the role base and generate event about
			// successful resolving
			roles.add(roleObject);
			eventQueue.offer(new AddedRoleEvent(roleObject));
			eventQueue.offer(new ResolvedRoleEvent(roleObject));
			return roleObject;
		} catch (InjectorException | ConverterException e) {
			eventQueue.offer(new UnresolvedRoleEvent(roleClass));
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
		public Object getLocal(String key) {
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
			} else if (key.equals(OWLOntology.class.getName())) {
				return beliefBase.getOntology();
			} else if (key.equals(IInjector.class.getName())) {
				return injector;
			} else if (key.equals(QueryEngine.class.getName())) {
				return beliefBase.getQueryEngine();
			} else {
				return null;
			}
		}

		@Override
		public <T> T getLocal(Class<T> key) {
			if (key == UUID.class) {
				return key.cast(uuid);
			} else if (key == IAgent.class) {
				return key.cast(Agent.this);
			} else if (key == IContainer.class) {
				return key.cast(getParent());
			} else if (key == IBeliefBase.class) {
				return key.cast(beliefBase);
			} else if (key == IGoalBase.class) {
				return key.cast(goalBase);
			} else if (key == IPlanBase.class) {
				return key.cast(planBase);
			} else if (key == OWLOntology.class) {
				return key.cast(beliefBase.getOntology());
			} else if (key == IInjector.class) {
				return key.cast(injector);
			} else if (key == QueryEngine.class) {
				return key.cast(beliefBase.getQueryEngine());
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
				OWLOntology.class.getName(),
				IInjector.class.getName(),
				QueryEngine.class.getName()
				// @formatter:on
			);
		}
	}

	AtomicInteger i = new AtomicInteger();

	protected final class ExecuteAction extends RecursiveAction {

		private static final long serialVersionUID = 1L;

		@Override
		protected void compute() {
			i.incrementAndGet();
			// System.out.println("-------------------- Execute " +
			// i.incrementAndGet() + " --------------------");
			// long begin = System.nanoTime();C
			IEvent<?> event = eventQueue.poll();
			if (event == null) {
				state = AgentState.WAITING;
				return;
			}
			// System.out.println("EventQueue: " + eventQueue.toString());
			// System.out.println("Event: " + event.toString());
			Iterable<Option> options = planBase.getOptions(event);
			options.forEach(option -> {
				try {
					option.getPlanBody().execute(getInjector(), option.getValues());
					// eventQueue.offer(new PlanFinishedEvent(planBody));
				} catch (Exception e) {
					e.printStackTrace();
					// eventQueue.offer(new PlanFailedEvent(planBody));
				}
			});
			// System.out.println("ThreadPool: " + executor.toString());
			// System.out.println("Executed " + (System.nanoTime() - begin) + "
			// nanos");

			if (getState() == AgentState.ACTIVE) {
				ExecuteAction action = new ExecuteAction();
				executor.submit(action);
			} else {
				state = AgentState.IDLE;
			}
		}

	}
}
