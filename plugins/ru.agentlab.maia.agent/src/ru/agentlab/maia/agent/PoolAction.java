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
import java.util.concurrent.RecursiveAction;

import ru.agentlab.maia.AgentState;
import ru.agentlab.maia.IEvent;

public class PoolAction extends RecursiveAction {

	private static final long serialVersionUID = 1L;

	private Agent agent;

	public PoolAction(Agent agent) {
		this.agent = agent;
	}

	@Override
	protected void compute() {
		IEvent event = agent.selectEvent();
		if (event == null) {
			agent.state = AgentState.WAITING;
			return;
		}
		List<Plan> relevantPlans = agent.selectRelevantPlans(event);
		List<Plan> applicablePlans = agent.selectApplicablePlans(relevantPlans);
		applicablePlans.forEach(plan -> plan.execute());

		// ...
		if (agent.getState() == AgentState.ACTIVE) {
			PoolAction action = new PoolAction(agent);
			invokeAll(action);
		}
	}

}
