/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import java.util.Collection;
import java.util.stream.Stream;

import com.google.common.collect.Multimap;

public interface IPlanBase {

	void add(Class<?> type, IPlan plan);

	void remove(Class<?> type, IPlan plan);

	Collection<IPlan> getPlans();

	Stream<IPlan> getPlansStream();

	Stream<Option> getOptions(IEvent<?> event);

	void addAll(Multimap<Class<?>, IPlan> map);

	Collection<IPlan> getStopPlans();

	Collection<IPlan> getStartPlans();

}
