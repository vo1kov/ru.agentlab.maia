/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.container.impl;

import java.lang.reflect.AccessibleObject;
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
import java.util.stream.Stream;

import javax.inject.Inject;
import javax.inject.Named;

import com.google.common.base.Preconditions;

import ru.agentlab.maia.container.IContainer;
import ru.agentlab.maia.container.IInjector;
import ru.agentlab.maia.container.InjectorException;

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

	/**
	 * {@inheritDoc}
	 */
	@Override
	public <T> T make(Class<T> clazz, Map<String, Object> extra) {
		Preconditions.checkNotNull(clazz, "Class of creating service should be non null");
		Preconditions.checkNotNull(extra, "Extra values should be non null, use empty map instead");

		Constructor<?>[] constructors = clazz.getDeclaredConstructors();
		Arrays.sort(constructors, comparator);

		Throwable lastException = null;
		for (Constructor<?> constructor : constructors) {
			boolean wasAccessible = setAccessible(constructor);
			try {
				Object instance = tryConstruct(constructor, extra);
				return clazz.cast(instance);
			} catch (NoClassDefFoundError | NoSuchMethodError | InstantiationException | IllegalAccessException
					| IllegalArgumentException | InvocationTargetException e) {
				lastException = e;
			} finally {
				revertAccessible(constructor, wasAccessible);
			}
		}
		if (lastException != null) {
			throw new InjectorException(lastException);
		} else {
			throw new InjectorException("Could not find satisfiable constructor in " + clazz.getName());
		}
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public void inject(Object service, Map<String, Object> extra) {
		Preconditions.checkNotNull(service, "Service for injection should be non null");
		Preconditions.checkNotNull(extra, "Extra values should be non null, use empty map instead");

		Stream.of(service.getClass().getDeclaredFields())
			.filter(field -> field.isAnnotationPresent(Inject.class))
			.forEach(field -> {
				Object value = resolveValue(field, extra);
				boolean wasAccessible = setAccessible(field);
				try {
					field.set(service, value);
				} catch (IllegalArgumentException | IllegalAccessException e) {
					throw new InjectorException();
				} finally {
					revertAccessible(field, wasAccessible);
				}
			});
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public Optional<Object> invoke(Object service, Method method, Map<String, Object> extra) {
		Preconditions.checkNotNull(service, "Service for invoking should be non null");
		Preconditions.checkNotNull(method, "Method to invoke should be non null");
		Preconditions.checkNotNull(extra, "Extra values should be non null, use empty map instead");

		Object[] values = Stream.of(method.getParameters())
			.map(parameter -> resolveValue(parameter, extra))
			.toArray(size -> new Object[size]);

		boolean wasAccessible = setAccessible(method);
		try {
			return Optional.ofNullable(method.invoke(service, values));
		} catch (IllegalArgumentException | IllegalAccessException | InvocationTargetException e) {
			throw new InjectorException(e);
		} finally {
			revertAccessible(method, wasAccessible);
		}
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public IContainer getContainer() {
		return container;
	}

	protected <T> T tryConstruct(Constructor<T> constructor, Map<String, Object> extra)
			throws InstantiationException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		if (constructor.getParameterCount() > 0 && !constructor.isAnnotationPresent(Inject.class)) {
			throw new InjectorException("Constructor with parameters should be annotated with @Inject annotation");
		}

		Object[] values = Stream.of(constructor.getParameters())
			.map(parameter -> resolveValue(parameter, extra))
			.toArray(size -> new Object[size]);

		return constructor.newInstance(values);
	}

	private boolean setAccessible(AccessibleObject object) {
		if (!object.isAccessible()) {
			object.setAccessible(true);
			return false;
		} else {
			return true;
		}
	}

	private void revertAccessible(AccessibleObject object, boolean wasAccessible) {
		if (!wasAccessible) {
			object.setAccessible(false);
		}
	}

	private Object resolveValue(Parameter parameter, Map<String, Object> extra) {
		if (parameter.isAnnotationPresent(Named.class)) {
			String key = parameter.getAnnotation(Named.class).value();
			return resolveValue(key, extra);
		} else {
			Class<?> key = parameter.getType();
			if (key.isPrimitive()) {
				key = (Class<?>) PRIMITIVES_TO_WRAPPERS.get(key);
			}
			return resolveValue(key, extra);
		}
	}

	private Object resolveValue(Field field, Map<String, Object> extra) {
		if (field.isAnnotationPresent(Named.class)) {
			String key = field.getAnnotation(Named.class).value();
			return resolveValue(key, extra);
		} else {
			Class<?> key = field.getType();
			if (key.isPrimitive()) {
				key = (Class<?>) PRIMITIVES_TO_WRAPPERS.get(key);
			}
			return resolveValue(key, extra);
		}
	}

	private Object resolveValue(Class<?> key, Map<String, Object> extra) {
		Object extraValue = extra.get(key.getName());
		if (extraValue != null) {
			return extraValue;
		} else {
			Object value = container.get(key);
			if (value == null) {
				throw new InjectorException("Value for key " + key + " did not found");
			}
			return value;
		}
	}

	private Object resolveValue(String key, Map<String, Object> extra) {
		Object extraValue = extra.get(key);
		if (extraValue != null) {
			return extraValue;
		} else {
			Object value = container.get(key);
			if (value == null) {
				throw new InjectorException("Value for key " + key + " did not found");
			}
			return value;
		}
	}
}
