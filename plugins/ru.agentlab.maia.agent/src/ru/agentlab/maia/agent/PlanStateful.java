/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.lang.reflect.Method;

import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.PlanExecutionException;

public class PlanStateful extends Plan {

	Object role;

	Method method;

	IInjector injector;

	public PlanStateful(Object object, Method method, IInjector injector) {
		this.role = object;
		this.method = method;
		this.injector = injector;
	}

	@Override
	public Object execute() throws PlanExecutionException {
		try {
			return injector.invoke(role, method, null);
		} catch (InjectorException | ContainerException e) {
			throw new PlanExecutionException(e);
		}
	}

}
