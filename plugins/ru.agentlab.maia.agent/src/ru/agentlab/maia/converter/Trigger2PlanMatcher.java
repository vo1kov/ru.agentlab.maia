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
		case BELIEF_ADDED:
			break;
		case BELIEF_CLASS_ADDED:
			break;
		case BELIEF_CLASS_ASSERTION_ADDED:
			break;
		case BELIEF_CLASS_ASSERTION_REMOVED:
			break;
		case BELIEF_DATA_PROPERTY_ASSERTION_ADDED:
			String[] atoms = template.split(" ");
			if (atoms.length != 3) {
				throw new IllegalArgumentException("@Trigger have wrong template");
			}
			return new EventMatcher(atoms[0], atoms[1], atoms[2]);
		case BELIEF_DATA_PROPERTY_ASSERTION_REMOVED:
			break;
		case BELIEF_OBJECT_PROPERTY_ASSERTION_ADDED:
			break;
		case BELIEF_OBJECT_PROPERTY_ASSERTION_REMOVED:
			break;
		case BELIEF_REMOVED:
			break;
		case GOAL_ADDED:
			break;
		case GOAL_FAILED:
			break;
		case GOAL_FINISHED:
			break;
		case GOAL_REMOVED:
			break;
		case GOAL_STARTED:
			break;
		case MESSAGE_ADDED:
			break;
		case MESSAGE_REMOVED:
			break;
		case PLAN_ADDED:
			break;
		case PLAN_FAILED:
			break;
		case PLAN_FINISHED:
			break;
		case PLAN_REMOVED:
			break;
		case PLAN_STARTED:
			break;
		default:
			break;
		}
		return null;
	}

}
