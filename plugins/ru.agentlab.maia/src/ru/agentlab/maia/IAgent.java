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
import java.util.Map;
import java.util.UUID;

import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.ResolveException;

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

	void deployTo(IContainer container) throws InjectorException, ContainerException;

	Object addRole(Class<?> roleClass, Map<String, Object> parameters) throws ResolveException;

	void send(IMessage message);

}
