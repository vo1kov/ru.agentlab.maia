/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import ru.agentlab.maia.exception.PlanExecutionException;

public class PlanStateles extends Plan {

	Object role;

	Method method;

	public PlanStateles(Object object, Method method) {
		this.role = object;
		this.method = method;
	}

	@Override
	public Object execute() throws PlanExecutionException {
		try {
			return method.invoke(role);
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			throw new PlanExecutionException(e);
		}
	}

}
