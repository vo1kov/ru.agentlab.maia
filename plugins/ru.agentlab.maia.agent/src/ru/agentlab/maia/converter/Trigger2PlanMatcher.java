/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.converter;

import ru.agentlab.maia.agent.IEventMatcher;
import ru.agentlab.maia.annotation.Trigger;
import ru.agentlab.maia.event.match.EventMatcher;

public class Trigger2PlanMatcher {

	public IEventMatcher convert(Trigger trigger) {
		String template = trigger.template();
		switch (trigger.type()) {
		case AGENT_BELIEF_ADDED:
			break;
		case AGENT_BELIEF_CLASS_ADDED:
			break;
		case AGENT_BELIEF_CLASS_ASSERTION_ADDED:
			break;
		case AGENT_BELIEF_CLASS_ASSERTION_REMOVED:
			break;
		case AGENT_BELIEF_DATA_PROPERTY_ASSERTION_ADDED:
			String[] atoms = template.split(" ");
			if (atoms.length != 3) {
				throw new IllegalArgumentException("@Trigger have wrong template");
			}
			return new EventMatcher(atoms[0], atoms[1], atoms[2]);
		case AGENT_BELIEF_DATA_PROPERTY_ASSERTION_REMOVED:
			break;
		case AGENT_BELIEF_OBJECT_PROPERTY_ASSERTION_ADDED:
			break;
		case AGENT_BELIEF_OBJECT_PROPERTY_ASSERTION_REMOVED:
			break;
		case AGENT_BELIEF_REMOVED:
			break;
		case AGENT_GOAL_ADDED:
			break;
		case AGENT_GOAL_FAILED:
			break;
		case AGENT_GOAL_FINISHED:
			break;
		case AGENT_GOAL_REMOVED:
			break;
		case AGENT_GOAL_STARTED:
			break;
		case AGENT_MESSAGE_ADDED:
			break;
		case AGENT_MESSAGE_REMOVED:
			break;
		case AGENT_PLAN_ADDED:
			break;
		case AGENT_PLAN_FAILED:
			break;
		case AGENT_PLAN_FINISHED:
			break;
		case AGENT_PLAN_REMOVED:
			break;
		case AGENT_PLAN_STARTED:
			break;
		case CONTAINER_AGENT_ADDED:
			break;
		case CONTAINER_AGENT_REMOVED:
			break;
		case CONTAINER_CHILD_ADDED:
			break;
		case CONTAINER_CHILD_REMOVED:
			break;
		case CONTAINER_SERVICE_ADDED:
			break;
		case CONTAINER_SERVICE_REMOVED:
			break;
		default:
			break;
		}
		return null;
	}

}
