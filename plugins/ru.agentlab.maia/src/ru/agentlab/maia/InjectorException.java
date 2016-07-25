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
 * @author Dmitriy Shishkin
 */
public class InjectorException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public InjectorException() {
	}

	public InjectorException(final String message) {
		super(message);
	}

	public InjectorException(final String message, final Throwable cause) {
		super(message, cause);
	}

	public InjectorException(final Throwable cause) {
		super(cause);
	}
}
