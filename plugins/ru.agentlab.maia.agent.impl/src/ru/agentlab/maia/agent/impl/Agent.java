/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.impl;

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

import org.semanticweb.owlapi.model.PrefixManager;
import org.semanticweb.owlapi.util.DefaultPrefixManager;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;

import ru.agentlab.maia.agent.AgentState;
import ru.agentlab.maia.agent.IAgent;
import ru.agentlab.maia.agent.IAgentRegistry;
import ru.agentlab.maia.agent.IEvent;
import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.agent.IPlanBase;
import ru.agentlab.maia.agent.IPlanBody;
import ru.agentlab.maia.agent.LocalAgentAddress;
import ru.agentlab.maia.agent.ResolveException;
import ru.agentlab.maia.agent.event.ExternalAddedEvent;
import ru.agentlab.maia.agent.event.RoleAddedEvent;
import ru.agentlab.maia.agent.event.RoleRemovedEvent;
import ru.agentlab.maia.agent.event.RoleResolvedEvent;
import ru.agentlab.maia.agent.event.RoleUnresolvedEvent;
import ru.agentlab.maia.container.IContainer;
import ru.agentlab.maia.container.IInjector;
import ru.agentlab.maia.container.InjectorException;
import ru.agentlab.maia.container.impl.Container;
import ru.agentlab.maia.converter.ConverterException;
import ru.agentlab.maia.converter.IPlanEventFilterConverter;
import ru.agentlab.maia.converter.IPlanExtraConverter;
import ru.agentlab.maia.converter.IPlanStateFilterConverter;
import ru.agentlab.maia.converter.PlanEventFilter;
import ru.agentlab.maia.converter.PlanExtra;
import ru.agentlab.maia.converter.PlanStateFilter;
import ru.agentlab.maia.filter.IPlanEventFilter;
import ru.agentlab.maia.filter.IPlanStateFilter;
import ru.agentlab.maia.filter.impl.PlanStateFilters;

/**
 * @author Dmitriy Shishkin
 */
public class Agent implements IAgent {

	protected final UUID uuid = UUID.randomUUID();

	@Inject
	protected ForkJoinPool executor;

	@Inject
	IAgentRegistry registry;

	protected AtomicReference<AgentState> state = new AtomicReference<>(AgentState.UNKNOWN);

	protected final IContainer agentContainer = new Container();

	protected final Queue<IEvent<?>> externalEventQueue = new ConcurrentLinkedQueue<>();

	protected final Queue<IEvent<?>> internalEventQueue = new LinkedList<>();

	protected final IPlanBase planBase = new PlanBase(internalEventQueue);

	protected final Set<Object> roles = new HashSet<>();

	{
		agentContainer.put(UUID.class, uuid);
		agentContainer.put(IAgent.class, this);
		agentContainer.put(Queue.class, internalEventQueue);
		agentContainer.put(IPlanBase.class, planBase);
	}

	protected void setState(AgentState newState) {
		state.set(newState);
	}

	public <T> void putService(Class<T> key, T value) {
		agentContainer.put(key, value);
	}

	public void putService(String key, Object value) {
		agentContainer.put(key, value);
	}

	public <T> T deployService(Class<T> clazz) {
		return getInjector().deploy(clazz);
	}

	public <T> T deployService(T service, Class<T> interf) {
		return getInjector().deploy(service, interf);
	}

	public <T> T deployService(Class<? super T> interf, Class<T> clazz) {
		T service = getInjector().make(clazz);
		return getInjector().deploy(service, interf);
	}

	public void deployService(String key, Object value) {
		agentContainer.put(key, value);
	}

	public <T> T getService(Class<T> key) {
		return agentContainer.get(key);
	}

	public Object getService(String key) {
		return agentContainer.get(key);
	}

	public IInjector getInjector() {
		return agentContainer.getInjector();
	}

	@Override
	public void fireExternalEvent(Object event) {
		externalEventQueue.offer(new ExternalAddedEvent(event));
		boolean started = state.compareAndSet(AgentState.WAITING, AgentState.ACTIVE);
		if (started) {
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
	public void deployTo(IContainer container) {
		setState(AgentState.TRANSIT);
		IInjector injector = agentContainer.getInjector();
		agentContainer.setParent(container);
		injector.inject(this);
		injector.invoke(this, PostConstruct.class, null, null);
		for (Object service : agentContainer.values()) {
			injector.inject(service);
			injector.invoke(service, PostConstruct.class, null, null);
		}
		container.put(uuid.toString(), this);
		registry.put(uuid, new LocalAgentAddress(this));
		setState(AgentState.IDLE);
	}

	@Override
	public Object addRole(Class<?> roleClass, Map<String, Object> parameters) {
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
			internalEventQueue.offer(new RoleRemovedEvent(roleObject));
		}
		return removed;
	}

	protected boolean internalRemoveAllRoles() {
		Stream<RoleRemovedEvent> events = roles.stream().map(role -> new RoleRemovedEvent(role));
		roles.clear();
		events.forEach(internalEventQueue::offer);
		return true;
	}

	protected Object internalAddRole(Class<?> roleClass, Map<String, Object> parameters) {
		try {
			// Create instance of role object
			IInjector injector = getInjector();
			Object roleObject = injector.make(roleClass, parameters);
			injector.inject(roleObject, parameters);
			injector.invoke(roleObject, PostConstruct.class, null, parameters);

			PrefixManager prefixes = new DefaultPrefixManager();
			putService(PrefixManager.class, prefixes);
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
			internalEventQueue.offer(new RoleAddedEvent(roleObject));
			internalEventQueue.offer(new RoleResolvedEvent(roleObject));
			return roleObject;
		} catch (InjectorException | ConverterException e) {
			internalEventQueue.offer(new RoleUnresolvedEvent(roleClass));
			throw new ResolveException(e);
		}
	}

	public Multimap<Class<?>, IPlan> getInitialPlans(Object role) {
		Multimap<Class<?>, IPlan> result = ArrayListMultimap.create();
		for (Method method : role.getClass().getDeclaredMethods()) {
			Map<String, Object> customData = new HashMap<>();
			IPlanStateFilter stateMatcher = getStateMatcher(role, method, customData);
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
			PlanExtra extraPlansAnnotation = annotation.annotationType().getAnnotation(PlanExtra.class);
			if (extraPlansAnnotation != null) {
				Class<? extends IPlanExtraConverter> converterClass = extraPlansAnnotation.converter();
				IPlanExtraConverter converter = injector.make(converterClass);
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
			PlanEventFilter eventMatcher = annotation.annotationType().getAnnotation(PlanEventFilter.class);
			if (eventMatcher != null) {
				Class<? extends IPlanEventFilterConverter> converterClass = eventMatcher.converter();
				Class<?> eventType = eventMatcher.eventType();
				IPlanEventFilterConverter converter = injector.make(converterClass);
				injector.inject(converter);
				injector.invoke(converter, PostConstruct.class, null, null);
				result.add(new Registration(converter.getMatcher(role, method, annotation, customData), eventType));
			}
		}
		return result;
	}

	private IPlanStateFilter getStateMatcher(Object role, Method method, Map<String, Object> customData) {
		IInjector injector = getInjector();
		Annotation[] annotations = method.getAnnotations();
		List<IPlanStateFilter> result = new LinkedList<>();
		for (Annotation annotation : annotations) {
			PlanStateFilter stateMatcher = annotation.annotationType().getAnnotation(PlanStateFilter.class);
			if (stateMatcher != null) {
				Class<? extends IPlanStateFilterConverter> converterClass = stateMatcher.converter();
				IPlanStateFilterConverter converter = injector.make(converterClass);
				injector.inject(converter);
				injector.invoke(converter, PostConstruct.class, null, null);
				result.add(converter.getMatcher(role, method, annotation, customData));
			}
		}
		if (result.size() == 0) {
			return PlanStateFilters.anything();
		} else if (result.size() == 1) {
			return result.get(0);
		} else {
			return PlanStateFilters.allOf(result);
		}
	}

	protected boolean isActive() {
		return getState() == AgentState.ACTIVE;
	}

	AtomicInteger i = new AtomicInteger();

	private static class Registration {

		IPlanEventFilter<?> mathcer;

		Class<?> eventType;

		public Registration(IPlanEventFilter<?> mathcer, Class<?> eventType) {
			super();
			this.mathcer = mathcer;
			this.eventType = eventType;
		}

		public IPlanEventFilter<?> getEventMatcher() {
			return mathcer;
		}

		public Class<?> getEventType() {
			return eventType;
		}

	}

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
				event = internalEventQueue.poll();
				if (event == null) {
					setState(AgentState.WAITING);
					return;
				}
			}

			// System.out.println("EventQueue: " + eventQueue.toString());
			// System.out.println("Event: " + event.toString());
			planBase.getOptions(event).forEach(option -> {
				try {
					Map<String, Object> values = option.getValues();
					IPlanBody planBody = option.getPlanBody();
					planBody.execute(getInjector(), values);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
			// System.out.println("ThreadPool: " + executor.toString());
			// System.out.println("Executed " + (System.nanoTime() - begin) + "
			// nanos");

			if (isActive()) {
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

			if (isActive()) {
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
