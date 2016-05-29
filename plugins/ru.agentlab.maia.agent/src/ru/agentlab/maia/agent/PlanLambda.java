/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.util.Map;

import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.exception.PlanExecutionException;

public class PlanLambda extends Plan {

	Runnable runnable;

	public PlanLambda(Object role, Runnable runnable) {
		super(role);
		this.runnable = runnable;
	}

	@Override
	public void execute(IInjector injector, Map<String, Object> variables) throws PlanExecutionException {
		runnable.run();
	}

}
