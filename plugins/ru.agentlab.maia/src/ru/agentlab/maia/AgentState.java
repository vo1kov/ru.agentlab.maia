/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

/**
 * 
 * @author Dmitriy Shishkin
 *
 */
public enum AgentState {

	UNKNOWN(0),

	DEPLOYED(1),

	UNRESOLVED(2),

	RESOLVED(3),

	ACTIVE(4),

	WAITING(5),

	TERMINATED(6),

	TRANSIT(10);

	public boolean isDeployed() {
		return this.level > 1;
	}

	public boolean isResolved() {
		return this.level > 3;
	}

	int level;

	AgentState(int level) {
		this.level = level;
	}

}
