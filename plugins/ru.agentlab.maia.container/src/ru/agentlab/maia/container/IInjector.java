/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.container;

import static com.google.common.base.Preconditions.checkNotNull;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Collections;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Stream;

import javax.annotation.PostConstruct;

import com.google.common.base.Preconditions;

public interface IInjector {

	/**
	 * Obtain an instance of the specified class and inject it with the context.
	 * Class'es scope dictates if a new instance of the class will be created,
	 * or existing instance will be reused.
	 * 
	 * @param <T>
	 *            type of creating service
	 * @param clazz
	 *            the class to be instantiated
	 * @param extra
	 *            additional values for injection
	 * @return an instance of the specified class
	 * @throws NullPointerException
	 *             if {@code clazz} or {@code extra} argument is {@code null}.
	 *             If you don't want use any extra values you should use empty
	 *             map instead of {@code null}
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	<T> T make(Class<T> clazz, Map<String, Object> extra);

	/**
	 * Obtain an instance of the specified class and inject it with the context.
	 * Class'es scope dictates if a new instance of the class will be created,
	 * or existing instance will be reused.
	 * 
	 * @param <T>
	 *            type of creating service
	 * @param clazz
	 *            the class to be instantiated
	 * @return an instance of the specified class
	 * @throws NullPointerException
	 *             if {@code clazz} argument is {@code null}
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default <T> T make(Class<T> clazz) {
		checkNotNull(clazz, "Class of creating service should be non null");

		return make(clazz, Collections.emptyMap());
	}

	/**
	 * Injects a context into a service with some extra values.
	 * 
	 * @param service
	 *            the object to perform injection on
	 * @param extra
	 *            additional values for injection
	 * @throws NullPointerException
	 *             if {@code service} or {@code extra} argument is {@code null}.
	 *             If you don't want use any extra values you should use empty
	 *             map instead of {@code null}
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	void inject(Object service, Map<String, Object> extra) throws InjectorException;

	/**
	 * Injects a context into a domain object.
	 * 
	 * @param service
	 *            the object to perform injection on
	 * @throws NullPointerException
	 *             if {@code service} argument is {@code null}
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default void inject(Object service) {
		checkNotNull(service, "Object to be injected should be non null");

		inject(service, Collections.emptyMap());
	}

	/**
	 * Create new service instance and register it to context.
	 * 
	 * @param <T>
	 *            type of deployed service
	 * @param clazz
	 *            type of service to be deployed
	 * @param extra
	 *            additional values for injection
	 * @return deployed service object
	 * @throws NullPointerException
	 *             if {@code clazz} or {@code extra} argument is {@code null}.
	 *             If you don't want use any extra values you should use empty
	 *             map instead of {@code null}
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default <T> T deploy(Class<T> clazz, Map<String, Object> extra) {
		checkNotNull(clazz, "Class of deploying service should be non null");
		checkNotNull(extra, "Extra values should be non null, use empty map instead");

		T service = make(clazz, extra);
		inject(service, extra);
		invoke(service, PostConstruct.class, extra);
		getContainer().put(service);
		return service;
	}

	/**
	 * Create new service instance and register it to context.
	 * 
	 * @param <T>
	 *            type of deployed service
	 * @param clazz
	 *            type of service to be deployed
	 * @return deployed service object
	 * @throws NullPointerException
	 *             if {@code clazz} argument is {@code null}
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default <T> T deploy(Class<T> clazz) {
		checkNotNull(clazz, "Class of deploying service should be non null");

		return deploy(clazz, Collections.emptyMap());
	}

	/**
	 * Create new service instance and register it to context with specified
	 * key.
	 * 
	 * @param <T>
	 *            type of deployed service
	 * @param clazz
	 *            type of service to be deployed
	 * @param key
	 *            key for registration in context
	 * @return deployed service object
	 * @throws NullPointerException
	 *             if {@code clazz} or {@code key} argument is {@code null}
	 * @throws IllegalArgumentException
	 *             if {@code key} argument is empty string
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default <T> T deploy(Class<T> clazz, String key, Map<String, Object> extra) {
		checkNotNull(clazz, "Class of service for deploying should be non null");
		checkNotNull(key, "Key for registration should be non null");
		Preconditions.checkArgument(!key.isEmpty(), "Key for registration should be non empty");
		checkNotNull(extra, "Extra values should be non null, use empty map instead");

		T service = make(clazz, extra);
		inject(service, extra);
		invoke(service, PostConstruct.class, extra);
		getContainer().put(key, service);
		return service;
	}

	/**
	 * Create new service instance and register it to context with specified
	 * key.
	 * 
	 * @param <T>
	 *            type of deployed service
	 * @param clazz
	 *            type of service to be deployed
	 * @param key
	 *            key for registration in context
	 * @return deployed service object
	 * @throws NullPointerException
	 *             if clazz or key is {@code null}
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default <T> T deploy(Class<T> clazz, String key) {
		checkNotNull(clazz, "Class of service for deploying should be non null");
		checkNotNull(key, "Key for registration should be non null");
		Preconditions.checkArgument(!key.isEmpty(), "Key for registration should be non empty");

		return deploy(clazz, key, Collections.emptyMap());
	}

	/**
	 * Create new service instance and register it to context with specified
	 * key.
	 * 
	 * @param <T>
	 *            type of deployed service
	 * @param clazz
	 *            type of service to be deployed
	 * @param interf
	 *            interface for registration in context
	 * @return deployed service object
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default <T> T deploy(Class<? extends T> serviceClass, Class<T> interf, Map<String, Object> extra) {
		checkNotNull(serviceClass, "Class of service for deploying should be non null");
		checkNotNull(interf, "Class of service for registration should be non null");
		checkNotNull(extra, "Extra values should be non null, use empty map instead");

		T service = make(serviceClass, extra);
		inject(service, extra);
		invoke(service, PostConstruct.class, extra);
		getContainer().put(interf, service);
		return service;
	}

	/**
	 * Create new service instance and register it to context with specified
	 * key.
	 * 
	 * @param <T>
	 *            type of deployed service
	 * @param clazz
	 *            type of service to be deployed
	 * @param interf
	 *            interface for registration in context
	 * @return deployed service object
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default <T> T deploy(Class<? extends T> serviceClass, Class<T> interf) {
		checkNotNull(serviceClass, "Class of service for deploying should be non null");
		checkNotNull(interf, "Class of service for registration should be non null");

		return deploy(serviceClass, interf, Collections.emptyMap());
	}

	/**
	 * Inject context to service object and register it to context
	 * 
	 * @param service
	 *            service object to be deployed
	 * @param extra
	 *            additional values for injection
	 * @return deployed service object
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default Object deploy(Object service, Map<String, Object> extra) {
		checkNotNull(service, "Service for deploying should be non null");
		checkNotNull(extra, "Extra values should be non null, use empty map instead");

		inject(service, extra);
		invoke(service, PostConstruct.class, extra);
		getContainer().put(service);
		return service;
	}

	/**
	 * Inject context to service object and register it to context
	 * 
	 * @param service
	 *            service object to be deployed
	 * @return deployed service object
	 * @throws NullPointerException
	 *             if service parameter is {@code null}
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default Object deploy(Object service) {
		checkNotNull(service, "Service for deploying should be non null");

		return deploy(service, Collections.emptyMap());
	}

	/**
	 * Inject context to service object and register it to context with
	 * specified key
	 * 
	 * @param service
	 *            service object to be deployed
	 * @param key
	 *            key for registration in context
	 * @param extra
	 *            additional values for injection
	 * @return deployed service object
	 * @throws NullPointerException
	 *             if service or key or extra parameter is {@code null}, if you
	 *             don't want use any extra values you should use empty map
	 *             instead of {@code null}
	 * @throws IllegalArgumentException
	 *             if key parameter is empty string
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default Object deploy(Object service, String key, Map<String, Object> extra) {
		checkNotNull(service, "Service for deploying should be non null");
		checkNotNull(key, "Key for registration should be non null");
		Preconditions.checkArgument(!key.isEmpty(), "Key for registration should be non empty");
		checkNotNull(extra, "Extra values should be non null, use empty map instead");

		inject(service, extra);
		invoke(service, PostConstruct.class, extra);
		getContainer().put(key, service);
		return service;
	}

	/**
	 * Inject context to service object and register it to context with
	 * specified key
	 * 
	 * @param service
	 *            service object to be deployed
	 * @param key
	 *            key for registration in context
	 * @return deployed service object
	 * @throws NullPointerException
	 *             if service or key parameter is {@code null}
	 * @throws IllegalArgumentException
	 *             if key parameter is empty string
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default Object deploy(Object service, String key) {
		checkNotNull(service, "Service for deploying should be non null");
		checkNotNull(key, "Key for registration should be non null");
		Preconditions.checkArgument(!key.isEmpty(), "Key for registration should be non empty");

		return deploy(service, key, Collections.emptyMap());
	}

	/**
	 * Inject context to service object and register it to context with
	 * specified key
	 * 
	 * @param <T>
	 *            type of deployed service
	 * @param service
	 *            service object to be deployed
	 * @param interf
	 *            interface for registration in context
	 * @param extra
	 *            additional values for injection
	 * @return deployed service object
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default <T> T deploy(T service, Class<? super T> interf, Map<String, Object> extra) {
		checkNotNull(service, "Service for deploying should be non null");
		checkNotNull(interf, "Interface class should be non null");
		checkNotNull(extra, "Extra values should be non null, use empty map instead");

		inject(service, extra);
		invoke(service, PostConstruct.class, extra);
		getContainer().put(interf, service);
		return service;
	}

	/**
	 * Inject context to service object and register it to context with
	 * specified key
	 * 
	 * @param <T>
	 *            type of deployed service
	 * @param service
	 *            service object to be deployed
	 * @param interf
	 *            interface for registration in context
	 * @return deployed service object
	 * @throws InjectorException
	 *             if an exception occurred while performing this operation
	 */
	default <T> T deploy(T service, Class<? super T> interf) {
		checkNotNull(service, "Service for deploying should be non null");
		checkNotNull(interf, "Interface class should be non null");

		return deploy(service, interf, Collections.emptyMap());
	}

	Optional<Object> invoke(Object service, Method method, Map<String, Object> extra) throws InjectorException;

	default Optional<Object> invoke(Object service, Method method) {
		checkNotNull(service, "Service for invoking should be non null");
		checkNotNull(method, "Method should be non null");

		return invoke(service, method, Collections.emptyMap());
	}

	default Optional<Object> invoke(Object service, String methodName, Map<String, Object> extra)
			throws InjectorException {
		checkNotNull(service, "Service for invoking should be non null");
		checkNotNull(methodName, "Method name should be non null");
		Preconditions.checkArgument(!methodName.isEmpty(), "Method name should be non empty");
		checkNotNull(extra, "Extra values should be non null, use empty map instead");

		return Stream
			.of(service.getClass().getDeclaredMethods())
			.filter(method -> method.getName().equals(methodName))
			.findFirst()
			.map(method -> invoke(service, method, extra));
	}

	default Optional<Object> invoke(Object service, String methodName) {
		checkNotNull(service, "Service for invoking should be non null");
		checkNotNull(methodName, "Method name should be non null");
		Preconditions.checkArgument(!methodName.isEmpty(), "Method name should be non empty");

		return invoke(service, methodName, Collections.emptyMap());
	}

	default Optional<Object> invoke(Object service, Class<? extends Annotation> qualifier, Map<String, Object> extra)
			throws InjectorException {
		checkNotNull(service, "Service for invoking should be non null");
		checkNotNull(qualifier, "Qualifier should be non null");
		checkNotNull(extra, "Extra values should be non null, use empty map instead");

		return Stream
			.of(service.getClass().getDeclaredMethods())
			.filter(method -> method.isAnnotationPresent(qualifier))
			.findFirst()
			.map(method -> invoke(service, method, extra));
	}

	default Optional<Object> invoke(Object service, Class<? extends Annotation> qualifier) {
		checkNotNull(service, "Service for invoking should be non null");
		checkNotNull(qualifier, "Qualifier should be non null");

		return invoke(service, qualifier, Collections.emptyMap());
	}

	/**
	 * @return container associated with this injector
	 */
	IContainer getContainer();

}