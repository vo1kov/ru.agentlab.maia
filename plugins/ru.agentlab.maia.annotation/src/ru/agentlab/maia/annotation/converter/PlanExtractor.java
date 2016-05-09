/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.annotation.converter;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import ru.agentlab.maia.agent.Plan;
import ru.agentlab.maia.annotation.TriggerAgentAddBelief;
import ru.agentlab.maia.annotation.TriggerAgentRemoveBelief;

public class PlanExtractor {

	public List<Plan> extract(Object object) {
		Class<?> clazz = object.getClass();
		return Arrays.stream(clazz.getMethods()).map(method -> {
			if (method.isAnnotationPresent(TriggerAgentAddBelief.class)) {
				return new Plan(object, method);
			} else if (method.isAnnotationPresent(TriggerAgentRemoveBelief.class)) {
				return new Plan(object, method);
			}
			return null;
		}).filter(Objects::nonNull).collect(Collectors.toList());
	}

}
