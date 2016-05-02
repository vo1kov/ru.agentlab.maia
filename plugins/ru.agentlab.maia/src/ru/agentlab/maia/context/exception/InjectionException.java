/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.context.exception;

/**
 * @author Dmitriy Shishkin
 */
public class InjectionException extends Exception {

	private static final long serialVersionUID = 1L;

	public InjectionException() {
		super();
	}

	public InjectionException(final String arg0) {
		super(arg0);
	}

	public InjectionException(final String arg0, final Throwable arg1) {
		super(arg0, arg1);
	}

	public InjectionException(final Throwable arg0) {
		super(arg0);
	}
}
