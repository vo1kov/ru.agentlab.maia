/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.util.function.Consumer;

import javax.inject.Inject;

import ru.agentlab.maia.IAgentContainer;
import ru.agentlab.maia.exception.PlanExecutionException;

public class PlanLambda extends Plan {

	@Inject
	IAgentContainer agent;

	Consumer<IAgentContainer> consumer;

	public PlanLambda(Consumer<IAgentContainer> consumer) {
		this.consumer = consumer;
	}

	@Override
	public Object execute() throws PlanExecutionException {
		consumer.accept(agent);
		return null;
	}

}
