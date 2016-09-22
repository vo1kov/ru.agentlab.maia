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
import java.util.concurrent.TimeUnit;

import ru.agentlab.maia.container.IContainer;

/**
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
public interface IAgent {

	void start();

	void tryStart();

	void tryStart(long timeout, TimeUnit unit) throws InterruptedException;

	void stop();

	UUID getUuid();

	IContainer getContainer();

	AgentState getState();

	void deployTo(IContainer container);

	Collection<IRole> getRoles();

	IRole addRole(Class<?> roleClass, Map<String, Object> parameters);

	IRole addRole(Object role, Map<String, Object> parameters);

	default IRole addRole(Class<?> roleClass) {
		return addRole(roleClass, Collections.emptyMap());
	}

	default IRole addRole(Object role) {
		return addRole(role, Collections.emptyMap());
	}

	IRole tryAddRole(Class<?> roleClass, Map<String, Object> parameters);

	IRole tryAddRole(Class<?> roleClass, Map<String, Object> parameters, long timeout, TimeUnit unit)
			throws InterruptedException;

	IRole tryAddRole(Object role, Map<String, Object> parameters);

	IRole tryAddRole(Object role, Map<String, Object> parameters, long timeout, TimeUnit unit)
			throws InterruptedException;

	default IRole tryAddRole(Class<?> roleClass) {
		return tryAddRole(roleClass, Collections.emptyMap());
	}

	default IRole tryAddRole(Object role) {
		return addRole(role, Collections.emptyMap());
	}

	void removeRole(IRole role);

	void tryRemoveRole(IRole role);

	void tryRemoveRole(IRole role, long timeout, TimeUnit unit) throws InterruptedException;

	void clearRoles();

	void tryClearRoles();

	void tryClearRoles(long timeout, TimeUnit unit) throws InterruptedException;

	void notify(IMessage event);

}
