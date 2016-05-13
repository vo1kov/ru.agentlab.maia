/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.converter;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.Plan;
import ru.agentlab.maia.annotation.Trigger;

public class PlanExtractionService {

	public List<IPlan> extract(Object contributor) {
		Class<?> clazz = contributor.getClass();
		List<IPlan> result = Arrays.stream(clazz.getMethods())
				.filter(method -> method.isAnnotationPresent(Trigger.class))
				.map(method -> new Plan(contributor, method)).collect(Collectors.toList());
		return result;
	}

}
