/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import java.util.List;
import java.util.UUID;

/**
 * @author Dmitry Shishkin
 */
public interface IAgent {
	
	void start();

	void stop();

	UUID getUuid();

	IContainer getContainer();

	AgentState getState();

	List<IRole> getRoles();
}
