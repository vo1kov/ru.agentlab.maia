/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.container.impl;

import static com.google.common.base.Preconditions.checkNotNull;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Stream;

import javax.inject.Inject;
import javax.inject.Named;

import org.apache.commons.lang.ClassUtils;
import org.apache.commons.lang.reflect.FieldUtils;

import ru.agentlab.maia.container.IContainer;
import ru.agentlab.maia.container.IInjector;
import ru.agentlab.maia.container.InjectorException;

/**
 * Injector for Dependency Injection.
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
public class Injector implements IInjector {

	private static final Map<Class<?>, Object> DEFAULT_VALUES = new HashMap<>();

	protected final static Comparator<Constructor<?>> comparator = (c1, c2) -> {
		return Integer.compare(c1.getParameterTypes().length, c2.getParameterTypes().length);
	};

	static {
		// @formatter:off
		DEFAULT_VALUES.put(byte.class,    (byte)    0);
		DEFAULT_VALUES.put(short.class,   (short)   0);
		DEFAULT_VALUES.put(int.class,     (int)     0);
		DEFAULT_VALUES.put(long.class,    (long)    0L);
		DEFAULT_VALUES.put(float.class,   (float)   0.0F);
		DEFAULT_VALUES.put(double.class,  (double)  0.0D);
		DEFAULT_VALUES.put(boolean.class, (boolean) false);
		DEFAULT_VALUES.put(char.class,    (char)    '\u0000');
		// @formatter:on
	}

	protected final IContainer container;

	public Injector(IContainer container) {
		this.container = container;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public IContainer getContainer() {
		return container;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public void inject(Object service, Map<String, Object> extra) {
		checkNotNull(service, "Service for injection should be non null");
		checkNotNull(extra, "Extra values should be non null, use empty map instead");
		getAllFields(service.getClass())
			.stream()
			.filter(field -> field.isAnnotationPresent(Inject.class))
			.distinct()
			.forEach(field -> {
				Object value = resolveValue(field, extra);
				try {
					FieldUtils.writeField(field, service, value, true);
				} catch (IllegalAccessException e1) {
					e1.printStackTrace();
				}
			});
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public Optional<Object> invoke(Object service, Method method, Map<String, Object> extra) {
		checkNotNull(service, "Service for invoking should be non null");
		checkNotNull(method, "Method to invoke should be non null");
		checkNotNull(extra, "Extra values should be non null, use empty map instead");
		Object[] values = Stream.of(method.getParameters()).map(parameter -> resolveValue(parameter, extra)).toArray(
			size -> new Object[size]);
		try {
			method.setAccessible(true);
			Object result = method.invoke(service, values);
			return Optional.ofNullable(result);
		} catch (IllegalArgumentException | IllegalAccessException | InvocationTargetException e) {
			throw new InjectorException(e);
		}
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public <T> T make(Class<T> clazz, Map<String, Object> extra) {
		checkNotNull(clazz, "Class of creating service should be non null");
		checkNotNull(extra, "Extra values should be non null, use empty map instead");
		Constructor<?>[] constructors = clazz.getDeclaredConstructors();
		Arrays.sort(constructors, comparator);
		Throwable lastException = null;
		for (Constructor<?> constructor : constructors) {
			constructor.setAccessible(true);
			try {
				Object instance = tryConstruct(constructor, extra);
				return clazz.cast(instance);
			} catch (NoClassDefFoundError | NoSuchMethodError | InstantiationException | IllegalAccessException
					| IllegalArgumentException | InvocationTargetException e) {
				lastException = e;
			}
		}
		if (lastException != null) {
			throw new InjectorException(lastException);
		} else {
			throw new InjectorException("Could not find satisfiable constructor in " + clazz.getName());
		}
	}

	@Override
	public void uninject(Object service) {
		checkNotNull(service, "Service for injection should be non null");
		getAllFields(service.getClass())
			.stream()
			.filter(field -> field.isAnnotationPresent(Inject.class))
			.distinct()
			.forEach(field -> {
				Object value = DEFAULT_VALUES.get(field.getType());
				try {
					FieldUtils.writeField(field, service, value, true);
				} catch (IllegalAccessException e1) {
					e1.printStackTrace();
				}
			});
	}

	/**
	 * Return the set of fields declared at all level of class hierarchy
	 * <p>
	 * TODO: Apache Commons 3.2+ have the same functionality.
	 * FieldUtils::getAllFieldsList.
	 */
	protected Set<Field> getAllFields(Class<?> clazz) {
		return getAllFieldsRec(clazz, new HashSet<Field>());
	}

	protected Set<Field> getAllFieldsRec(Class<?> clazz, Set<Field> fields) {
		Class<?> superClazz = clazz.getSuperclass();
		if (superClazz != null) {
			getAllFieldsRec(superClazz, fields);
		}
		fields.addAll(Arrays.asList(clazz.getDeclaredFields()));
		return fields;
	}

	protected Object resolveValue(Class<?> key, Map<String, Object> extra) {
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

	protected Object resolveValue(Field field, Map<String, Object> extra) {
		if (field.isAnnotationPresent(Named.class)) {
			String key = field.getAnnotation(Named.class).value();
			return resolveValue(key, extra);
		} else {
			Class<?> key = ClassUtils.primitiveToWrapper(field.getType());
			return resolveValue(key, extra);
		}
	}

	protected Object resolveValue(Parameter parameter, Map<String, Object> extra) {
		if (parameter.isAnnotationPresent(Named.class)) {
			String key = parameter.getAnnotation(Named.class).value();
			return resolveValue(key, extra);
		} else {
			Class<?> key = ClassUtils.primitiveToWrapper(parameter.getType());
			return resolveValue(key, extra);
		}
	}

	protected Object resolveValue(String key, Map<String, Object> extra) {
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

	protected <T> T tryConstruct(Constructor<T> constructor, Map<String, Object> extra)
			throws InstantiationException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		if (constructor.getParameterCount() > 0 && !constructor.isAnnotationPresent(Inject.class)) {
			throw new InjectorException("Constructor with parameters should be annotated with @Inject annotation");
		}
		Object[] values = Stream
			.of(constructor.getParameters())
			.map(parameter -> resolveValue(parameter, extra))
			.toArray(size -> new Object[size]);

		return constructor.newInstance(values);
	}
}
