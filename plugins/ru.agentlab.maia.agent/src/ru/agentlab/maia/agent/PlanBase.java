/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import javax.inject.Inject;

import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.InjectorException;

public class PlanBase implements IPlanBase {

	@Inject
	protected IContainer container;

	@Override
	public void addPlan(IPlan plan) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addPlanPackage(Class<?> planPackage) throws InjectorException, ContainerException {
		IInjector injector = container.getInjector();
		Object contributor = injector.make(planPackage);
		injector.inject(contributor);
		
	}

}
