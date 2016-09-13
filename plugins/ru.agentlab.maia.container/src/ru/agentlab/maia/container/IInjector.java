/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.container;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Collections;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Stream;

import javax.annotation.PostConstruct;

public interface IInjector {

	<T> T make(Class<T> clazz, Map<String, Object> additional) throws InjectorException;

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
	default <T> T make(Class<T> clazz) throws InjectorException {
		return make(clazz, null);
	}

	void inject(Object object, Map<String, Object> additional) throws InjectorException;

	/**
	 * <p>
	 * Injects a context into a domain object.
	 * 
	 * @param object
	 *            the object to perform injection on
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default void inject(Object object) throws InjectorException {
		inject(object, null);
	}

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
	default <T> T deploy(Class<T> serviceClass) throws InjectorException {
		T service = make(serviceClass);
		inject(service);
		invoke(service, PostConstruct.class, null);
		getContainer().put(serviceClass, service);
		return service;
	}

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
	default <T> T deploy(Class<T> serviceClass, String key) throws InjectorException {
		T service = make(serviceClass);
		inject(service);
		invoke(service, PostConstruct.class, null);
		getContainer().put(key, service);
		return service;
	}

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
	default <T> T deploy(Class<? extends T> serviceClass, Class<T> interf) throws InjectorException {
		T service = make(serviceClass);
		inject(service);
		invoke(service, PostConstruct.class, null);
		getContainer().put(interf, service);
		return service;
	}

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
	default Object deploy(Object service) throws InjectorException {
		inject(service);
		invoke(service, PostConstruct.class, null);
		Class<?> _class = service.getClass();
		String _name = _class.getName();
		getContainer().put(_name, service);
		return service;
	}

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
	default Object deploy(Object service, String key) throws InjectorException {
		inject(service);
		invoke(service, PostConstruct.class, null);
		getContainer().put(key, service);
		return service;
	}

	default <T> T deploy(T service, Class<? super T> interf) throws InjectorException {
		inject(service);
		invoke(service, PostConstruct.class, null);
		getContainer().put(interf, service);
		return service;
	}

	default Optional<Object> invoke(Object object, Method method) throws InjectorException {
		return invoke(object, method, Collections.emptyMap());
	}

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

	Optional<Object> invoke(Object object, Method method, Map<String, Object> additional) throws InjectorException;

	default Optional<Object> invoke(Object object, String methodName) throws InjectorException {
		return Stream.of(object.getClass().getDeclaredMethods()).filter(method -> method.getName().equals(methodName))
				.findFirst().map(method -> invoke(object, method));
	}

	default Optional<Object> invoke(Object object, String methodName, Map<String, Object> additional)
			throws InjectorException {
		return Stream.of(object.getClass().getDeclaredMethods()).filter(method -> method.getName().equals(methodName))
				.findFirst().map(method -> invoke(object, method, additional));
	}

	default Optional<Object> invoke(Object object, Class<? extends Annotation> qualifier) throws InjectorException {
		return Stream.of(object.getClass().getDeclaredMethods()).filter(method -> method.isAnnotationPresent(qualifier))
				.findFirst().map(method -> invoke(object, method));
	}

	default Optional<Object> invoke(Object object, Class<? extends Annotation> qualifier,
			Map<String, Object> additional) throws InjectorException {
		return Stream.of(object.getClass().getDeclaredMethods()).filter(method -> method.isAnnotationPresent(qualifier))
				.findFirst().map(method -> invoke(object, method, additional));
	}

	IContainer getContainer();

}