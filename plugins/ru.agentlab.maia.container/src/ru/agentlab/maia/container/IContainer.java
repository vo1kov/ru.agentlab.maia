/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.container;

import java.util.Collection;
import java.util.Set;
import java.util.UUID;

import com.google.common.base.Preconditions;

//import ru.agentlab.maia.exception.ServiceNotFound;

/**
 * Container for storing services and agents.
 * 
 * @author Dmitriy Shishkin
 */
public interface IContainer {

	/**
	 * <p>
	 * Returns parent of context or <code>null</code> if context is a root
	 * context.
	 * 
	 * @return parent of context or <code>null</code> if context have no parent.
	 */
	IContainer getParent();

	IInjector getInjector();

	Iterable<IContainer> getChilds();

	void addChild(final IContainer container);

	void removeChild(final IContainer container);

	void clearChilds();

	/**
	 * <p>
	 * Change parent of context. If <code>null</code> then context become to be
	 * a root context.
	 * </p>
	 * 
	 * @param parent
	 *            the new parent context. If <code>null</code> then context
	 *            become to be a root context.
	 */
	IContainer setParent(final IContainer parent);

	/**
	 * <p>
	 * Retrieve unique id of context.
	 * </p>
	 * 
	 * @return unique id of context. Can not be null.
	 */
	UUID getUuid();

	/**
	 * <p>
	 * Returns the context value associated with the given name. Returns
	 * <code>null</code> if no such value is defined or computable by this
	 * context, or if the assigned value is <code>null</code>.
	 * </p>
	 * 
	 * @param key
	 *            key of registered service as plain string. If
	 *            <code>null</code> then IllegalArgumentException will be
	 *            thrown.
	 * @return an object corresponding to the given name, or <code>null</code>.
	 * 
	 * @see #getService(Class)
	 */
	default Object get(final String key) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null");
		}
		Object result = getLocal(key);
		if (result != null) {
			return result;
		}
		IContainer parent = getParent();
		if (parent != null) {
			return parent.get(key);
		} else {
			return null;
		}
	}

	/**
	 * <p>
	 * Returns the context value associated with the given name. Returns
	 * <code>null</code> if no such value is defined or computable by this
	 * context, or if the assigned value is <code>null</code>.
	 * </p>
	 * 
	 * @param key
	 *            key of registered service as type of the value to return. If
	 *            <code>null</code> then IllegalArgumentException will be
	 *            thrown.
	 * @param <T>
	 *            type of returning value.
	 * @return an object corresponding to the given class, can be
	 *         <code>null</code>.
	 * @throws ClassCastException
	 *             if context contains value but with different type.
	 * 
	 * @see #getService(String)
	 */
	default <T> T get(Class<T> key) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null");
		}
		Object result = getLocal(key);
		if (result != null) {
			return key.cast(result);
		}
		IContainer p = getParent();
		if (p != null) {
			return p.get(key);
		} else {
			return null;
		}
	}

	/**
	 * <p>
	 * Returns the context value associated with the given key in this context,
	 * or <code>null</code> if no such value is defined in this context.
	 * </p>
	 * <p>
	 * This method does not search for the value on other elements on the
	 * context tree.
	 * </p>
	 * 
	 * @param key
	 *            key of registered service as plain string. If
	 *            <code>null</code> then IllegalArgumentException will be
	 *            thrown.
	 * @param <T>
	 *            type of returning value
	 * @return an object corresponding to the given name, or <code>null</code>
	 * 
	 * @see #getServiceLocal(Class)
	 */
	Object getLocal(final String key);

	/**
	 * <p>
	 * Returns the context value associated with the given key in this context,
	 * or <code>null</code> if no such value is defined in this context.
	 * </p>
	 * <p>
	 * This method does not search for the value on other elements on the
	 * context tree.
	 * </p>
	 * 
	 * @param key
	 *            key of registered service as type of the value to return. If
	 *            <code>null</code> then IllegalArgumentException will be
	 *            thrown.
	 * @param <T>
	 *            type of returning value.
	 * @return an object corresponding to the given class, can be
	 *         <code>null</code>.
	 * @throws ClassCastException
	 *             if context contains value but with different type.
	 * 
	 * @see #getServiceLocal(String)
	 */
	default <T> T getLocal(Class<T> key) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null");
		}
		if (key == IInjector.class) {
			return key.cast(getInjector());
		}
		return key.cast(getLocal(key.getName()));
	}

	/**
	 * <p>
	 * Returns keys of registered services.
	 * </p>
	 * 
	 * @return keys of registered services.
	 */
	Set<Object> getKeySet();

	/**
	 * <p>
	 * Removes the given name and any corresponding value from this context.
	 * </p>
	 * <p>
	 * Removal can never affect a parent context, so it is possible that a
	 * subsequent call to {@link #get(String)} with the same name will return a
	 * non-null result, due to a value being stored in a parent context.
	 * </p>
	 * 
	 * @param key
	 *            key of registered service as plain string. If
	 *            <code>null</code> then IllegalArgumentException will be
	 *            thrown.
	 * @return value removed from context
	 * 
	 * @see #remove(Class)
	 */
	Object remove(final String key);

	/**
	 * <p>
	 * Removes the given name and any corresponding value from this context.
	 * </p>
	 * <p>
	 * Removal can never affect a parent context, so it is possible that a
	 * subsequent call to {@link #get(String)} with the same name will return a
	 * non-null result, due to a value being stored in a parent context.
	 * </p>
	 * 
	 * @param key
	 *            key of registered service as type of the value to return. If
	 *            <code>null</code> then IllegalArgumentException will be
	 *            thrown.
	 * @return value removed from context
	 * 
	 * @see #remove(String)
	 */
	default Object remove(final Class<?> key) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null");
		}
		return remove(key.getName());
	}

	boolean clear();

	/**
	 * <p>
	 * Sets a value to be associated with a given name in this context. The
	 * value can may be <code>null</code>.
	 * </p>
	 * 
	 * @param key
	 *            key of registered service as plain string. If
	 *            <code>null</code> then IllegalArgumentException will be
	 *            thrown.
	 * @param value
	 *            the value to be stored that can return the stored value.
	 * 
	 * @see #putService(Class, Object)
	 */
	Object put(final String key, final Object value);

	/**
	 * <p>
	 * Sets a value to be associated with a given class in this context.
	 * </p>
	 * 
	 * @param key
	 *            key of registered service as type of the value to return. If
	 *            <code>null</code> then IllegalArgumentException will be
	 *            thrown.
	 * @param service
	 *            the value to be stored
	 * @param <T>
	 *            type of specified value.
	 */
	default <T> Object put(Class<? super T> key, T service) {
		Preconditions.checkNotNull(key, "Key must be not null");

		return put(key.getName(), service);
	}

	default Object put(final Object value) {
		return put(value.getClass().getName(), value);
	}

	Collection<Object> values();

	Object remove(Object service);
}
