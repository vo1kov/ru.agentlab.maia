/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
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
@SuppressWarnings("all")
public interface IAgent {
	
	/**
	 * @author Dmitry Shishkin
	 */
	public enum State {
		UNKNOWN,

		WAITING,

		ACTIVE,

		SUSPENDED,

		TRANSIT,

		INITIATED;
	}

	UUID getUuid();

	List<IRole> getRoles();

	void start();

	void stop();

	boolean isActive();

	void setBehaviour(final IBehaviour behaviour);

	IBehaviour getBehaviour();

	IContainer getContainer();
}
