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

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IEventMatcher;

public class Plan implements IPlan {

	Object planPackage;

	Method method;

	IEventMatcher matcher;

	public Plan(Object object, Method method) {
		super();
		this.planPackage = object;
		this.method = method;
	}

	@Override
	public Object execute() {
		try {
			return method.invoke(planPackage);
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public IEventMatcher getMatcher() {
		return matcher;
	}

}
