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
import java.util.Arrays;
import java.util.Map;
import java.util.Optional;

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

	default <T> T deploy(T service, Class<T> interf) throws InjectorException {
		inject(service);
		invoke(service, PostConstruct.class, null);
		getContainer().put(interf, service);
		return service;
	}

	Object invoke(Object object, Method method) throws InjectorException;

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

	Object invoke(Object object, Method method, Object defaultValue) throws InjectorException;

	Object invoke(Object object, Method method, Map<String, Object> additional) throws InjectorException;

	Object invoke(Object object, Method method, Object defaultValue, Map<String, Object> additional)
			throws InjectorException;

	default Object invoke(Object object, String methodName) throws InjectorException {
		Method method = Arrays.stream(object.getClass().getDeclaredMethods())
				.filter(m -> m.getName().equals(methodName)).findFirst()
				.orElseThrow(() -> new InjectorException("Object have no method with name " + methodName));
		return invoke(object, method);
	}

	default Object invoke(Object object, String methodName, Object defaultValue) throws InjectorException {
		Optional<Method> method = Arrays.stream(object.getClass().getMethods())
				.filter(m -> m.getName().equals(methodName)).findFirst();
		if (method.isPresent()) {
			return invoke(object, method.get(), defaultValue);
		} else {
			return defaultValue;
		}
	}

	default Object invoke(Object object, String methodName, Map<String, Object> additional) throws InjectorException {
		Method method = Arrays.stream(object.getClass().getDeclaredMethods())
				.filter(m -> m.getName().equals(methodName)).findFirst()
				.orElseThrow(() -> new InjectorException("Object have no method with name " + methodName));
		return invoke(object, method, additional);
	}

	default Object invoke(Object object, String methodName, Object defaultValue, Map<String, Object> additional)
			throws InjectorException {
		Optional<Method> method = Arrays.stream(object.getClass().getMethods())
				.filter(m -> m.getName().equals(methodName)).findFirst();
		if (method.isPresent()) {
			return invoke(object, method.get(), defaultValue, additional);
		} else {
			return defaultValue;
		}
	}

	default Object invoke(Object object, Class<? extends Annotation> qualifier) throws InjectorException {
		Method method = Arrays.stream(object.getClass().getDeclaredMethods())
				.filter(m -> m.isAnnotationPresent(qualifier)).findFirst().orElseThrow(
						() -> new InjectorException("Object have no method annotated with @" + qualifier.getName()));
		return invoke(object, method);
	}

	default Object invoke(Object object, Class<? extends Annotation> qualifier, Object defaultValue)
			throws InjectorException {
		Optional<Method> method = Arrays.stream(object.getClass().getMethods())
				.filter(m -> m.isAnnotationPresent(qualifier)).findFirst();
		if (method.isPresent()) {
			return invoke(object, method.get(), defaultValue);
		} else {
			return defaultValue;
		}
	}

	default Object invoke(Object object, Class<? extends Annotation> qualifier, Object defaultValue,
			Map<String, Object> additional) throws InjectorException {
		Optional<Method> method = Arrays.stream(object.getClass().getMethods())
				.filter(m -> m.isAnnotationPresent(qualifier)).findFirst();
		if (method.isPresent()) {
			return invoke(object, method.get(), defaultValue, additional);
		} else {
			return defaultValue;
		}
	}

	default Object invoke(Object object, Class<? extends Annotation> qualifier, Map<String, Object> additional)
			throws InjectorException {
		Method method = Arrays.stream(object.getClass().getDeclaredMethods())
				.filter(m -> m.isAnnotationPresent(qualifier)).findFirst().orElseThrow(
						() -> new InjectorException("Object have no method annotated with @" + qualifier.getName()));
		return invoke(object, method, additional);
	}

	IContainer getContainer();

}