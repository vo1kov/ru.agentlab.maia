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
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.Future;

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

	void deployTo(IContainer container) throws InjectorException, ContainerException;

	Collection<Object> getRoles();

	Object addRole(Class<?> roleClass, Class<? extends IConverter> converterClass, Map<String, Object> parameters)
			throws ResolveException;

	default Object addRole(Class<?> roleClass, Class<? extends IConverter> converterClass) throws ResolveException {
		return addRole(roleClass, converterClass, null);
	}

	boolean removeRole(Object roleObject);

	boolean removeAllRoles();

	Future<Object> submitAddRole(Class<?> roleClass, Class<? extends IConverter> converterClass,
			Map<String, Object> parameters);

	default Future<Object> submitAddRole(Class<?> roleClass, Class<? extends IConverter> converterClass) {
		return submitAddRole(roleClass, converterClass, null);
	}

	Future<Boolean> submitRemoveRole(Object roleObject);

	Future<Boolean> submitRemoveAllRoles();

	void send(IMessage message);

}
