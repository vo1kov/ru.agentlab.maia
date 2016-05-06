/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.InjectorException;

public interface IInjector {

	/**
	 * <p>
	 * Obtain an instance of the specified class and inject it with the context.
	 * Class'es scope dictates if a new instance of the class will be created,
	 * or existing instance will be reused.
	 * 
	 * @param clazz
	 *            the class to be instantiated
	 * @param T
	 *            type of creating service
	 * @return an instance of the specified class
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	<T> T make(Class<T> clazz) throws InjectorException, ContainerException;

	/**
	 * <p>
	 * Injects a context into a domain object.
	 * 
	 * @param object
	 *            the object to perform injection on
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	void inject(Object object) throws InjectorException, ContainerException;

	/**
	 * <p>
	 * Create new service instance and register it to context
	 * 
	 * @param clazz
	 *            type of service to be deployed
	 * @return deployed service object
	 * @param T
	 *            type of deployed service
	 * @throws InjectorException
	 *             when creating or registering falls
	 */
	<T> T deploy(Class<T> clazz) throws InjectorException, ContainerException;

	/**
	 * <p>
	 * Create new service instance and register it to context with specified key
	 * 
	 * @param clazz
	 *            type of service to be deployed
	 * @param key
	 *            key for registration in context
	 * @param T
	 *            type of deployed service
	 * @return deployed service object
	 * @throws InjectorException
	 *             when creating or registering falls
	 */
	<T> T deploy(Class<T> clazz, String key) throws InjectorException, ContainerException;

	/**
	 * <p>
	 * Create new service instance and register it to context with specified key
	 * 
	 * @param clazz
	 *            type of service to be deployed
	 * @param interf
	 *            interface for registration in context
	 * @param T
	 *            type of deployed service
	 * @return deployed service object
	 * @throws InjectorException
	 *             when creating or registering falls
	 */
	<T> T deploy(Class<? extends T> clazz, Class<T> interf) throws InjectorException, ContainerException;

	/**
	 * <p>
	 * Inject context to service object and register it to context
	 * 
	 * @param service
	 *            service object to be deployed
	 * @param T
	 *            type of deployed service
	 * @return deployed service object
	 * @throws InjectorException
	 *             when injecting falls
	 */
	Object deploy(Object service) throws InjectorException, ContainerException;

	/**
	 * <p>
	 * Inject context to service object and register it to context with
	 * specified key
	 * 
	 * @param service
	 *            service object to be deployed
	 * @param key
	 *            key for registration in context
	 * @param T
	 *            type of deployed service
	 * @return deployed service object
	 * @throws InjectorException
	 *             when creating or registering falls
	 */
	Object deploy(Object service, String key) throws InjectorException, ContainerException;

	/**
	 * <p>
	 * Inject context to service object and register it to context with
	 * specified key
	 * 
	 * @param service
	 *            service object to be deployed
	 * @param interf
	 *            interface for registration in context
	 * @param T
	 *            type of deployed service
	 * @return deployed service object
	 * @throws InjectorException
	 *             when creating or registering falls
	 */

	Object invoke(Object object, Method method, Object defaultValue) throws InjectorException, ContainerException;

	Object invoke(Object object, String methodName, Object defaultValue) throws InjectorException, ContainerException;

	Object invoke(Object object, Class<? extends Annotation> qualifier, Object defaultValue)
			throws InjectorException, ContainerException;

	Object invoke(Object object, Method method) throws InjectorException, ContainerException;

	Object invoke(Object object, String methodName) throws InjectorException, ContainerException;

	Object invoke(Object object, Class<? extends Annotation> qualifier) throws InjectorException, ContainerException;

	<T> T deploy(T service, Class<T> interf) throws InjectorException, ContainerException;

}