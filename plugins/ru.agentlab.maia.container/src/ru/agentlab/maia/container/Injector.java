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
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.inject.Named;

import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.ServiceNotFound;

/**
 * Injector for Dependency Injection.
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
public class Injector implements IInjector {

	private static final Map<Class<?>, Class<?>> PRIMITIVES_TO_WRAPPERS = new HashMap<Class<?>, Class<?>>();

	static {
		PRIMITIVES_TO_WRAPPERS.put(boolean.class, Boolean.class);
		PRIMITIVES_TO_WRAPPERS.put(byte.class, Byte.class);
		PRIMITIVES_TO_WRAPPERS.put(char.class, Character.class);
		PRIMITIVES_TO_WRAPPERS.put(double.class, Double.class);
		PRIMITIVES_TO_WRAPPERS.put(float.class, Float.class);
		PRIMITIVES_TO_WRAPPERS.put(int.class, Integer.class);
		PRIMITIVES_TO_WRAPPERS.put(long.class, Long.class);
		PRIMITIVES_TO_WRAPPERS.put(short.class, Short.class);
		PRIMITIVES_TO_WRAPPERS.put(void.class, Void.class);
	}

	private final static Comparator<Constructor<?>> comparator = (c1, c2) -> {
		return Integer.compare(c1.getParameterTypes().length, c2.getParameterTypes().length);
	};

	private final IContainer container;

	public Injector(IContainer container) {
		this.container = container;
	}

	@Override
	public <T> T make(Class<T> clazz) throws InjectorException, ContainerException {
		try {
			Constructor<?>[] constructors = clazz.getConstructors();
			Arrays.sort(constructors, comparator);
			for (Constructor<?> constructor : constructors) {
				Object instance = tryConstruct(constructor);
				if (instance != null) {
					return clazz.cast(instance);
				}
			}
			throw new InjectorException("Could not find satisfiable constructor in " + clazz.getName());
		} catch (NoClassDefFoundError | NoSuchMethodError e) {
			throw new InjectorException(e);
		}
	}

	@Override
	public Object invoke(Object object, Class<? extends Annotation> qualifier)
			throws InjectorException, ContainerException {
		Optional<Method> method = Arrays.stream(object.getClass().getDeclaredMethods())
				.filter(m -> m.isAnnotationPresent(qualifier)).findFirst();
		if (method.isPresent()) {
			return invoke(object, method.get(), false, null);
		} else {
			throw new InjectorException("Object have no method annotated with @" + qualifier.getName());
		}
	}

	@Override
	public Object invoke(Object object, String methodName) throws InjectorException, ContainerException {
		Optional<Method> method = Arrays.stream(object.getClass().getDeclaredMethods())
				.filter(m -> m.getName().equals(methodName)).findFirst();
		if (method.isPresent()) {
			return invoke(object, method.get(), false, null);
		} else {
			throw new InjectorException("Object have no method with name " + methodName);
		}
	}

	@Override
	public Object invoke(Object object, Method method) throws InjectorException, ContainerException {
		return invoke(object, method, false, null);
	}

	@Override
	public Object invoke(Object object, Class<? extends Annotation> qualifier, Object defaultValue)
			throws InjectorException, ContainerException {
		Optional<Method> method = Arrays.stream(object.getClass().getDeclaredMethods())
				.filter(m -> m.isAnnotationPresent(qualifier)).findFirst();
		if (method.isPresent()) {
			return invoke(object, method.get(), false, null);
		} else {
			return defaultValue;
		}
	}

	@Override
	public Object invoke(Object object, String methodName, Object defaultValue)
			throws InjectorException, ContainerException {
		Optional<Method> method = Arrays.stream(object.getClass().getDeclaredMethods())
				.filter(m -> m.getName().equals(methodName)).findFirst();
		if (method.isPresent()) {
			return invoke(object, method.get(), false, null);
		} else {
			return defaultValue;
		}
	}

	@Override
	public Object invoke(Object object, Method method, Object defaultValue)
			throws InjectorException, ContainerException {
		return invoke(object, method, true, defaultValue);
	}

	@Override
	public void inject(Object object) throws InjectorException, ContainerException {
		if (object == null) {
			throw new NullPointerException();
		}

		Field[] fields = Arrays.stream(object.getClass().getDeclaredFields())
				.filter(f -> f.isAnnotationPresent(Inject.class)).toArray(size -> new Field[size]);
		Object[] keys = resolveKeys(fields);
		Object[] values = resolveValues(keys);
		if (values.length < fields.length) {
			throw new InjectorException("Unresolved value for type " + keys[values.length]);
		}
		for (int i = 0; i < fields.length; i++) {
			Field field = fields[i];
			Object value = values[i];
			boolean wasAccessible = true;
			if (!field.isAccessible()) {
				field.setAccessible(true);
				wasAccessible = false;
			}
			try {
				field.set(object, value);
			} catch (IllegalArgumentException | IllegalAccessException e) {
				throw new InjectorException();
			} finally {
				if (!wasAccessible) {
					field.setAccessible(false);
				}
			}
		}
	}

	/**
	 * PostConstruct method is invoked before registration service in context.
	 * Services can remove old services from context in PostConstruct method.
	 * 
	 * @throws ServiceNotFound
	 */
	@Override
	public <T> T deploy(Class<T> serviceClass) throws InjectorException, ContainerException {
		T service = make(serviceClass);
		inject(service);
		invoke(service, PostConstruct.class, null);
		container.put(serviceClass, service);
		return service;
	}

	@Override
	public Object deploy(Object service) throws InjectorException, ContainerException {
		inject(service);
		invoke(service, PostConstruct.class, null);
		Class<?> _class = service.getClass();
		String _name = _class.getName();
		container.put(_name, service);
		return service;
	}

	@Override
	public <T> T deploy(Class<T> serviceClass, String key) throws InjectorException, ContainerException {
		T service = make(serviceClass);
		inject(service);
		invoke(service, PostConstruct.class, null);
		container.put(key, service);
		return service;
	}

	@Override
	public <T> T deploy(Class<? extends T> serviceClass, Class<T> interf) throws InjectorException, ContainerException {
		T service = make(serviceClass);
		inject(service);
		invoke(service, PostConstruct.class, null);
		container.put(interf, service);
		return service;
	}

	@Override
	public Object deploy(Object service, String key) throws InjectorException, ContainerException {
		inject(service);
		invoke(service, PostConstruct.class, null);
		container.put(key, service);
		return service;
	}

	@Override
	public <T> T deploy(T service, Class<T> interf) throws InjectorException, ContainerException {
		inject(service);
		invoke(service, PostConstruct.class, null);
		container.put(interf, service);
		return service;
	}

	protected Object invoke(Object object, Method method, boolean haveDefault, Object defaultValue)
			throws InjectorException, ContainerException {
		if (method == null) {
			if (haveDefault) {
				return defaultValue;
			} else {
				throw new InjectorException();
			}
		}
		Object[] keys = resolveKeys(method.getParameters());
		Object[] values = resolveValues(keys);
		if (values.length < method.getParameterCount()) {
			if (haveDefault) {
				return defaultValue;
			} else {
				throw new InjectorException();
			}
		}
		boolean wasAccessible = true;
		if (!method.isAccessible()) {
			method.setAccessible(true);
			wasAccessible = false;
		}
		try {
			return method.invoke(object, values);
		} catch (IllegalArgumentException | IllegalAccessException | InvocationTargetException e) {
			if (haveDefault) {
				return defaultValue;
			} else {
				throw new InjectorException(e);
			}
		} finally {
			if (!wasAccessible) {
				method.setAccessible(false);
			}
			Arrays.fill(values, null);
		}
	}

	protected <T> T tryConstruct(Constructor<T> constructor) throws InjectorException {
		if (!constructor.isAnnotationPresent(Inject.class) && constructor.getParameterTypes().length != 0) {
			return null;
		}
		Parameter[] params = constructor.getParameters();
		Object[] keys = resolveKeys(params);
		Object[] values;
		try {
			values = resolveValues(keys);
		} catch (ServiceNotFound e) {
			return null;
		}
		T result = null;
		boolean wasAccessible = true;
		if (!constructor.isAccessible()) {
			constructor.setAccessible(true);
			wasAccessible = false;
		}
		try {
			result = constructor.newInstance(values);
		} catch (IllegalArgumentException | InstantiationException | IllegalAccessException
				| InvocationTargetException e) {
		} finally {
			if (!wasAccessible) {
				constructor.setAccessible(false);
			}
			Arrays.fill(values, null);
		}
		return result;
	}

	protected Object[] resolveKeys(Parameter[] parameters) {
		return Arrays.stream(parameters).map(this::resolveParameter).toArray();
	}

	protected Object[] resolveKeys(Field[] fields) {
		return Arrays.stream(fields).map(this::resolveField).toArray();
	}

	private Object resolveParameter(Parameter parameter) {
		if (parameter.isAnnotationPresent(Named.class)) {
			return parameter.getAnnotation(Named.class).value();
		}
		Class<?> type = parameter.getType();
		return type.isPrimitive() ? (Class<?>) PRIMITIVES_TO_WRAPPERS.get(type) : type;
	}

	private Object resolveField(Field field) {
		if (field.isAnnotationPresent(Named.class)) {
			return field.getAnnotation(Named.class).value();
		}
		Class<?> type = field.getType();
		return type.isPrimitive() ? (Class<?>) PRIMITIVES_TO_WRAPPERS.get(type) : type;
	}

	protected Object[] resolveValues(Object[] keys) throws ServiceNotFound {
		Object[] result = new Object[keys.length];
		for (int i = 0; i < keys.length; i++) {
			Object value = resolveValue(keys[i]);
			result[i] = value;
		}
		return result;
	}

	private Object resolveValue(Object key) throws ServiceNotFound {
		if (key instanceof String) {
			return container.get((String) key);
		} else if (key instanceof Class<?>) {
			return container.get((Class<?>) key);
		} else {
			throw new ServiceNotFound();
		}
	}
}
