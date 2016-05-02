/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

/**
 * @author Dmitriy Shishkin
 */
@SuppressWarnings("all")
public interface IBehaviour {
	/**
	 * @author Dmitriy Shishkin
	 */
	public static class Parameter<T extends Object> {

		protected final String name;

		protected final Class<T> type;

		protected final transient AtomicReference<AtomicReference<T>> reference = new AtomicReference<AtomicReference<T>>();

		protected final boolean isOptional;

		public boolean isOptional() {
			return this.isOptional;
		}

		public Parameter(final String name, final Class<T> type, final boolean isOptional) {
			this.name = name;
			this.type = type;
			this.isOptional = isOptional;
		}

		public Parameter(final String name, final Class<T> type) {
			this(name, type, false);
		}

		public void setValue(final T v) {
			AtomicReference<T> _get = this.reference.get();
			if (_get != null) {
				_get.set(v);
			}
		}

		public T getValue() {
			AtomicReference<T> _get = this.reference.get();
			T _get_1 = null;
			if (_get != null) {
				_get_1 = _get.get();
			}
			return _get_1;
		}

		public AtomicReference<T> getReference() {
			return this.reference.get();
		}

		public Object link(final IBehaviour.Parameter<T> param) {
			return null;
		}

		public void unlink() {
			AtomicReference<T> _atomicReference = new AtomicReference<T>(null);
			this.reference.set(_atomicReference);
		}

		public String getName() {
			return this.name;
		}

		public Class<T> getType() {
			return this.type;
		}
	}

	/**
	 * @author Dmitry Shishkin
	 */
	public static class Exception<T extends Object> {

		protected final Class<T> type;

		public Exception(final Class<T> type) {
			this.type = type;
		}

		public Class<T> getType() {
			return this.type;
		}
	}

	/**
	 * @author Dmitry Shishkin
	 */
	public enum State {
		UNKNOWN,

		READY,

		WORKING,

		BLOCKED,

		SUCCESS,

		FAILED;
	}

	public abstract UUID getUuid();

	/**
	 * Invoke one step of execution of the task.
	 */
	public abstract void execute() throws java.lang.Exception;

	/**
	 * Retrieve task state.
	 * 
	 * @return task state.
	 */
	public abstract IBehaviour.State getState();

	/**
	 * Retrieve all task inputs.
	 * 
	 * @return collection of task inputs or {@code null} if task have no inputs.
	 */
	public abstract Iterable<IBehaviour.Parameter<?>> getInputs();

	/**
	 * Retrieve all task outputs.
	 * 
	 * @return collection of task outputs or {@code null} if task have no
	 *         outputs.
	 */
	public abstract Iterable<IBehaviour.Parameter<?>> getOutputs();

	/**
	 * Add specified parameter as input to task.
	 * 
	 * @param parameter
	 *            parameter to be added.
	 */
	public abstract void addInput(final IBehaviour.Parameter<?> parameter);

	/**
	 * Add specified parameter as output to task.
	 * 
	 * @param parameter
	 *            parameter to be added.
	 */
	public abstract void addOutput(final IBehaviour.Parameter<?> parameter);

	/**
	 * Remove specified parameter from task inputs.
	 * 
	 * 
	 * @param parameter
	 *            parameter to be removed.
	 */
	public abstract void removeInput(final IBehaviour.Parameter<?> parameter);

	/**
	 * Remove specified parameter from task outputs.
	 * 
	 * @param parameter
	 *            parameter to be removed.
	 */
	public abstract void removeOutput(final IBehaviour.Parameter<?> parameter);

	/**
	 * Remove all parameters from task inputs.
	 */
	public abstract void clearInputs();

	/**
	 * Remove all parameters from task outputs.
	 * 
	 */
	public abstract void clearOutputs();

	public abstract Iterable<IBehaviour.Exception<?>> getExceptions();

	public abstract void addException(final IBehaviour.Exception<?> exception);

	public abstract void removeException(final IBehaviour.Exception<?> exception);

	public abstract void clearExceptions();
}
