/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
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
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Stream;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.semanticweb.owlapi.model.OWLOntology;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Multimap;

import de.derivo.sparqldlapi.QueryEngine;
import ru.agentlab.maia.AgentState;
import ru.agentlab.maia.ContainerException;
import ru.agentlab.maia.ConverterException;
import ru.agentlab.maia.ExternalAddedEvent;
import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.IStateMatcher;
import ru.agentlab.maia.InjectorException;
import ru.agentlab.maia.ResolveException;
import ru.agentlab.maia.agent.match.StateMatchers;
import ru.agentlab.maia.agent.role.event.RoleAddedEvent;
import ru.agentlab.maia.agent.role.event.RoleRemovedEvent;
import ru.agentlab.maia.agent.role.event.RoleResolvedEvent;
import ru.agentlab.maia.agent.role.event.RoleUnresolvedEvent;
import ru.agentlab.maia.annotation.EventMatcher;
import ru.agentlab.maia.annotation.ExtraPlans;
import ru.agentlab.maia.annotation.IEventMatcherConverter;
import ru.agentlab.maia.annotation.IExtraPlansConverter;
import ru.agentlab.maia.annotation.IStateMatcherConverter;
import ru.agentlab.maia.annotation.StateMatcher;
import ru.agentlab.maia.container.Injector;

/**
 * @author Dmitriy Shishkin
 */
public class Agent implements IAgent {

	protected final UUID uuid = UUID.randomUUID();

	@Inject
	protected ForkJoinPool executor;

	protected AtomicReference<AgentState> state = new AtomicReference<>(AgentState.UNKNOWN);

	protected final AgentContainer agentContainer = new AgentContainer();

	// protected final Queue<IMessage> messageQueue = new
	// ConcurrentLinkedQueue<>();

	protected final Queue<IEvent<?>> externalEventQueue = new ConcurrentLinkedQueue<>();

	protected final Queue<IEvent<?>> eventQueue = new LinkedList<>();

	protected final IBeliefBase beliefBase = new BeliefBase();

	protected final IGoalBase goalBase = new GoalBase(eventQueue);

	protected final IPlanBase planBase = new PlanBase(eventQueue);

	protected final Set<Object> roles = new HashSet<>();

	protected void setState(AgentState newState) {
		state.set(newState);
		// System.out.println("Agent [" + uuid.toString() + "] change state to
		// [" + state.toString() + "]");
	}

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
	public void fireExternalEvent(Object event) {
		externalEventQueue.offer(new ExternalAddedEvent(event));
		boolean started = state.compareAndSet(AgentState.WAITING, AgentState.ACTIVE);
		if (started) {
			// System.out.println("Agent [" + uuid.toString() + "] change state
			// to [" + state.toString() + "]");
			executor.submit(new ExecuteAction());
		}
	}

	@Override
	public void start() {
		executor.submit(new StartAgentAction());
	}

	@Override
	public void stop() {
		setState(AgentState.STOPPING);
	}

	// @Override
	// public void send(IMessage message) {
	// messageQueue.offer(message);
	// }

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
		return state.get();
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
		setState(AgentState.IDLE);
	}

	@Override
	public Object addRole(Class<?> roleClass, Map<String, Object> parameters) throws ResolveException {
		if (roleClass == null) {
			throw new NullPointerException("Role class can't be null");
		}
		switch (state.get()) {
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
		switch (state.get()) {
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
		switch (state.get()) {
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
			eventQueue.offer(new RoleRemovedEvent(roleObject));
		}
		return removed;
	}

	protected boolean internalRemoveAllRoles() {
		Stream<RoleRemovedEvent> events = roles.stream().map(role -> new RoleRemovedEvent(role));
		roles.clear();
		events.forEach(eventQueue::offer);
		return true;
	}

	protected Object internalAddRole(Class<?> roleClass, Map<String, Object> parameters) throws ResolveException {
		try {
			// Create instance of role object
			IInjector injector = getInjector();
			Object roleObject = injector.make(roleClass, parameters);
			injector.inject(roleObject, parameters);
			injector.invoke(roleObject, PostConstruct.class, null, parameters);

			// Now role object have resolved all field dependencies. Need to
			// convert role object to initial beliefs, goals and plans.
			Multimap<Class<?>, IPlan> plans = getInitialPlans(roleObject);

			// If no exceptions was thrown by this moment then we can add
			// beliefs, goals and plans converted from role object and
			// role object themselves
			planBase.addAll(plans);

			// Add role object to the role base and generate event about
			// successful resolving
			roles.add(roleObject);
			eventQueue.offer(new RoleAddedEvent(roleObject));
			eventQueue.offer(new RoleResolvedEvent(roleObject));
			return roleObject;
		} catch (InjectorException | ConverterException e) {
			eventQueue.offer(new RoleUnresolvedEvent(roleClass));
			throw new ResolveException(e);
		}
	}

	public Multimap<Class<?>, IPlan> getInitialPlans(Object role) {
		Multimap<Class<?>, IPlan> result = ArrayListMultimap.create();
		for (Method method : role.getClass().getDeclaredMethods()) {
			Map<String, Object> customData = new HashMap<>();
			IStateMatcher stateMatcher = getStateMatcher(role, method, customData);
			List<Registration> eventMatchers = getEventMatchers(role, method, customData);
			Multimap<Class<?>, IPlan> extraPlans = getExtraPlans(role, method, customData);
			eventMatchers.forEach(registration -> result.put(registration.getEventType(),
					new Plan(role, method, registration.getEventMatcher(), stateMatcher)));
			result.putAll(extraPlans);
		}
		return result;
	}

	private Multimap<Class<?>, IPlan> getExtraPlans(Object role, Method method, Map<String, Object> customData) {
		IInjector injector = getInjector();
		Annotation[] annotations = method.getAnnotations();
		Multimap<Class<?>, IPlan> result = ArrayListMultimap.create();
		for (Annotation annotation : annotations) {
			ExtraPlans extraPlansAnnotation = annotation.annotationType().getAnnotation(ExtraPlans.class);
			if (extraPlansAnnotation != null) {
				Class<? extends IExtraPlansConverter> converterClass = extraPlansAnnotation.converter();
				IExtraPlansConverter converter = injector.make(converterClass);
				injector.inject(converter);
				injector.invoke(converter, PostConstruct.class, null, null);
				Multimap<Class<?>, IPlan> plans = converter.getPlans(role, method, annotation, customData);
				result.putAll(plans);
			}
		}
		return result;
	}

	private List<Registration> getEventMatchers(Object role, Method method, Map<String, Object> customData) {
		IInjector injector = getInjector();
		Annotation[] annotations = method.getAnnotations();
		List<Registration> result = new LinkedList<>();
		for (Annotation annotation : annotations) {
			EventMatcher eventMatcher = annotation.annotationType().getAnnotation(EventMatcher.class);
			if (eventMatcher != null) {
				Class<? extends IEventMatcherConverter> converterClass = eventMatcher.converter();
				Class<?> eventType = eventMatcher.eventType();
				IEventMatcherConverter converter = injector.make(converterClass);
				injector.inject(converter);
				injector.invoke(converter, PostConstruct.class, null, null);
				result.add(new Registration(converter.getMatcher(role, method, annotation, customData), eventType));
			}
		}
		return result;
	}

	private IStateMatcher getStateMatcher(Object role, Method method, Map<String, Object> customData) {
		IInjector injector = getInjector();
		Annotation[] annotations = method.getAnnotations();
		List<IStateMatcher> result = new LinkedList<>();
		for (Annotation annotation : annotations) {
			StateMatcher stateMatcher = annotation.annotationType().getAnnotation(StateMatcher.class);
			if (stateMatcher != null) {
				Class<? extends IStateMatcherConverter> converterClass = stateMatcher.converter();
				IStateMatcherConverter converter = injector.make(converterClass);
				injector.inject(converter);
				injector.invoke(converter, PostConstruct.class, null, null);
				result.add(converter.getMatcher(role, method, annotation, customData));
			}
		}
		if (result.size() == 0) {
			return StateMatchers.anything();
		} else if (result.size() == 1) {
			return result.get(0);
		} else {
			return StateMatchers.allOf(result);
		}
	}

	private static class Registration {

		IEventMatcher<?> mathcer;

		Class<?> eventType;

		public Registration(IEventMatcher<?> mathcer, Class<?> eventType) {
			super();
			this.mathcer = mathcer;
			this.eventType = eventType;
		}

		public IEventMatcher<?> getEventMatcher() {
			return mathcer;
		}

		public Class<?> getEventType() {
			return eventType;
		}

	}

	protected Collection<IPlan> getRolePlans() {
		return null;
	}

	protected final class AgentContainer implements IContainer {
		@Inject
		protected final AtomicReference<IContainer> parent = new AtomicReference<IContainer>(null);
		final IInjector injector = new Injector(this);

		@Override
		public Iterable<IContainer> getChilds() {
			return null;
		}

		@Override
		public void addChild(IContainer container) {
			throw new UnsupportedOperationException();
		}

		@Override
		public void removeChild(IContainer container) {
			throw new UnsupportedOperationException();
		}

		@Override
		public void clearChilds() {
			throw new UnsupportedOperationException();
		}

		@Override
		public Object remove(String key) {
			throw new UnsupportedOperationException();
		}

		@Override
		public boolean clear() {
			throw new UnsupportedOperationException();
		}

		@Override
		public Object put(String key, Object value) {
			throw new UnsupportedOperationException();
		}

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
			// long begin = System.nanoTime();
			IEvent<?> event = externalEventQueue.poll();
			if (event == null) {
				event = eventQueue.poll();
				if (event == null) {
					setState(AgentState.WAITING);
					return;
				}
			}

			// System.out.println("EventQueue: " + eventQueue.toString());
			// System.out.println("Event: " + event.toString());
			planBase.getOptions(event).forEach(option -> {
				try {
					option.getPlanBody().execute(getInjector(), option.getValues());
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
			// System.out.println("ThreadPool: " + executor.toString());
			// System.out.println("Executed " + (System.nanoTime() - begin) + "
			// nanos");

			if (getState() == AgentState.ACTIVE) {
				ExecuteAction action = new ExecuteAction();
				executor.submit(action);
			} else {
				setState(AgentState.IDLE);
			}
		}

	}

	protected final class StartAgentAction extends RecursiveAction {

		private static final long serialVersionUID = 1L;

		@Override
		protected void compute() {
			setState(AgentState.ACTIVE);
			planBase.getStartPlans().forEach(plan -> {
				try {
					plan.getPlanBody().execute(getInjector(), null);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});

			if (getState() == AgentState.ACTIVE) {
				ExecuteAction action = new ExecuteAction();
				executor.submit(action);
			} else {
				setState(AgentState.IDLE);
			}
		}
	}

	protected final class StopAgentAction extends RecursiveAction {

		private static final long serialVersionUID = 1L;

		@Override
		protected void compute() {
			planBase.getStopPlans().forEach(plan -> {
				try {
					plan.getPlanBody().execute(getInjector(), null);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
			setState(AgentState.IDLE);
		}
	}

}
