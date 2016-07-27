/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent;

/**
 * 
 * @author Dmitriy Shishkin
 *
 */
public enum AgentState {

	UNKNOWN,

	ACTIVE,

	WAITING,

	STOPPING,

	IDLE,

	TRANSIT;

	public static boolean isDeployed(AgentState state) {
		return state != UNKNOWN;
	}

}
