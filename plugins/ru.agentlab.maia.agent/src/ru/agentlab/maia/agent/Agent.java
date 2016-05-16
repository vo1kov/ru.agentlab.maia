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
import java.util.concurrent.RecursiveAction;

import javax.inject.Inject;

import ru.agentlab.maia.AgentState;
import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.IRole;
import ru.agentlab.maia.IRoleBase;
import ru.agentlab.maia.agent.event.PlanFailedEvent;
import ru.agentlab.maia.agent.event.PlanFinishedEvent;
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

	protected final IMessageQueue messageQueue = new MessageQueue();

	protected final IEventQueue eventQueue = new EventQueue();

	protected final IBeliefBase beliefBase = new BeliefBase(eventQueue, uuid.toString());

	protected final IGoalBase goalBase = new GoalBase(eventQueue);

	protected final IPlanBase planBase = new PlanBase(eventQueue);

	protected final IRoleBase roleBase = new RoleBase(eventQueue, container.getInjector());

	@Override
	public void start() {
		state = AgentState.ACTIVE;
		executor.submit(new ExecuteAction());
	}

	@Override
	public void stop() {
		state = AgentState.TERMINATED;
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

	// protected List<IPlan> extract(Class<?> clazz) throws InjectorException,
	// ContainerException {
	//
	// Object contributor = container.getInjector().make(clazz);
	//
	// List<IPlan> result = Arrays.stream(clazz.getMethods())
	// .filter(method ->
	// method.isAnnotationPresent(ru.agentlab.maia.agent.Plan.class)).map(method
	// -> {
	// EventType type =
	// method.getAnnotation(ru.agentlab.maia.agent.Plan.class).value();
	// IEventMatcher<?> matcher;
	// switch (type) {
	// case BELIEF_ADDED:
	// case BELIEF_CLASS_ADDED:
	// case BELIEF_CLASS_ASSERTION_ADDED:
	// case BELIEF_CLASS_ASSERTION_REMOVED:
	// case BELIEF_DATA_PROPERTY_ASSERTION_ADDED:
	// case BELIEF_DATA_PROPERTY_ASSERTION_REMOVED:
	// case BELIEF_OBJECT_PROPERTY_ASSERTION_ADDED:
	// case BELIEF_OBJECT_PROPERTY_ASSERTION_REMOVED:
	// case BELIEF_REMOVED:
	// matcher = extractBeliefEventMatcher(method);
	// break;
	// case GOAL_ADDED:
	// case GOAL_FAILED:
	// case GOAL_FINISHED:
	// case GOAL_REMOVED:
	// matcher = extractGoalEventMatcher(method);
	// break;
	// case MESSAGE_ADDED:
	// case MESSAGE_REMOVED:
	//
	// break;
	// case PLAN_ADDED:
	// case PLAN_FAILED:
	// case PLAN_FINISHED:
	// case PLAN_REMOVED:
	//
	// break;
	// case ROLE_ADDED:
	// case ROLE_REMOVED:
	// case ROLE_RESOLVED:
	// case ROLE_UNRESOLVED:
	// matcher = extractRoleEventMatcher(method);
	// break;
	// }
	// return new Plan(contributor, method);
	// }).collect(Collectors.toList());
	// return result;
	// }

	// private IEventMatcher<?> extractBeliefEventMatcher(Method method) {
	// EventBelief beliefAnnotation = method.getAnnotation(EventBelief.class);
	// if (beliefAnnotation != null) {
	// String template = beliefAnnotation.value();
	// String[] atoms = template.split(" ");
	// if (atoms.length != 3) {
	// throw new IllegalArgumentException("@" + EventBelief.class.getName() + "
	// have wrong template");
	// }
	// return new BeliefBaseEventMatcher(atoms[0], atoms[1], atoms[2]);
	// }
	// return null;
	// }
	//
	// private IEventMatcher<?> extractGoalEventMatcher(Method method) {
	// GoalAdded goalAnnotation = method.getAnnotation(GoalAdded.class);
	// if (goalAnnotation != null) {
	// String template = goalAnnotation.value();
	// String[] atoms = template.split(" ");
	// if (atoms.length != 3) {
	// throw new IllegalArgumentException("@" + EventBelief.class.getName() + "
	// have wrong template");
	// }
	// return new BeliefBaseEventMatcher(atoms[0], atoms[1], atoms[2]);
	// }
	// return null;
	// }
	//
	// private IEventMatcher<?> extractRoleEventMatcher(Method method) {
	// RoleAdded goalAnnotation = method.getAnnotation(RoleAdded.class);
	// if (goalAnnotation != null) {
	// Class<?> template = goalAnnotation.value();
	// return new RoleBaseEventMatcher(template);
	// }
	// return null;
	// }

	@Override
	public void deployTo(IContainer container) throws InjectorException, ContainerException {
		container.getInjector().inject(this);
		container.put(uuid.toString(), this);
		state = AgentState.DEPLOYED;
	}

	@Override
	public void addRole(Class<?> roleClass) {
		roleBase.add(roleClass);

	}

	@Override
	public void resolve() throws ResolveException {
		roleBase.resolveAll();
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

		protected List<Plan> selectRelevantPlans(IEvent<?> event) {
			return null;
		}

		protected List<Plan> selectApplicablePlans(List<Plan> relevantPlans) {
			return null;
		}

	}
}
