/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.Future;

import ru.agentlab.maia.container.IContainer;

/**
 * @author Dmitry Shishkin
 */
public interface IAgent {

	void start();

	void stop();

	UUID getUuid();

	IContainer getContainer();

	AgentState getState();

	void deployTo(IContainer container);

	Collection<Object> getRoles();

	Object addRole(Class<?> roleClass, Map<String, Object> parameters);

	default Object addRole(Class<?> roleClass) {
		return addRole(roleClass, Collections.emptyMap());
	}

	boolean removeRole(Object roleObject);

	boolean removeAllRoles();

	Future<Object> submitAddRole(Class<?> roleClass, Map<String, Object> parameters);

	default Future<Object> submitAddRole(Class<?> roleClass) {
		return submitAddRole(roleClass, Collections.emptyMap());
	}

	Future<Boolean> submitRemoveRole(Object roleObject);

	Future<Boolean> submitRemoveAllRoles();

	// void send(IMessage message);

	void notify(IMessage event);

}
