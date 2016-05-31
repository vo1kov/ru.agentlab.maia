/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.container;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.exception.InjectorException;

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
	public <T> T make(Class<T> clazz, Map<String, Object> additional) throws InjectorException {
		try {
			Constructor<?>[] constructors = clazz.getDeclaredConstructors();
			Arrays.sort(constructors, comparator);
			for (Constructor<?> constructor : constructors) {
				Object instance = tryConstruct(constructor, additional);
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
	public Object invoke(Object object, Method method) throws InjectorException {
		return invoke(object, method, false, null, null);
	}

	@Override
	public Object invoke(Object object, Method method, Object defaultValue) throws InjectorException {
		return invoke(object, method, true, defaultValue, null);
	}

	@Override
	public Object invoke(Object object, Method method, Map<String, Object> additional) throws InjectorException {
		return invoke(object, method, false, null, additional);
	}

	@Override
	public Object invoke(Object object, Method method, Object defaultValue, Map<String, Object> additional)
			throws InjectorException {
		return invoke(object, method, true, defaultValue, additional);
	}

	@Override
	public void inject(Object object, Map<String, Object> additional) throws InjectorException {
		if (object == null) {
			throw new NullPointerException();
		}

		Field[] fields = Arrays.stream(object.getClass().getDeclaredFields())
				.filter(f -> f.isAnnotationPresent(Inject.class)).toArray(size -> new Field[size]);

		Object[] values = new Object[fields.length];
		for (int i = 0; i < fields.length; i++) {
			Object resolved = resolveValue(fields[i], additional);
			if (resolved == null) {
				throw new InjectorException();
			}
			values[i] = resolved;
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

	@Override
	public IContainer getContainer() {
		return container;
	}

	protected Object invoke(Object object, Method method, boolean haveDefault, Object defaultValue,
			Map<String, Object> additional) throws InjectorException {
		if (method == null) {
			if (haveDefault) {
				return defaultValue;
			} else {
				throw new NullPointerException();
			}
		}
		Parameter[] parameters = method.getParameters();
		Object[] values = new Object[parameters.length];
		for (int i = 0; i < parameters.length; i++) {
			Object resolved = resolveValue(parameters[i], additional);
			if (resolved == null) {
				if (haveDefault) {
					return defaultValue;
				} else {
					throw new InjectorException();
				}
			}
			values[i] = resolved;
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

	protected <T> T tryConstruct(Constructor<T> constructor, Map<String, Object> additional) throws InjectorException {
		if (constructor.getParameterCount() == 0) {
			boolean wasAccessible = true;
			if (!constructor.isAccessible()) {
				constructor.setAccessible(true);
				wasAccessible = false;
			}
			try {
				return constructor.newInstance();
			} catch (IllegalArgumentException | InstantiationException | IllegalAccessException
					| InvocationTargetException e) {
				return null;
			} finally {
				if (!wasAccessible) {
					constructor.setAccessible(false);
				}
			}
		} else {
			if (!constructor.isAnnotationPresent(Inject.class)) {
				return null;
			}
			Parameter[] parameters = constructor.getParameters();
			Object[] values = new Object[parameters.length];
			for (int i = 0; i < parameters.length; i++) {
				Object resolved = resolveValue(parameters[i], additional);
				if (resolved == null) {
					return null;
				}
				values[i] = resolved;
			}
			boolean wasAccessible = true;
			if (!constructor.isAccessible()) {
				constructor.setAccessible(true);
				wasAccessible = false;
			}
			try {
				return constructor.newInstance(values);
			} catch (IllegalArgumentException | InstantiationException | IllegalAccessException
					| InvocationTargetException e) {
				return null;
			} finally {
				if (!wasAccessible) {
					constructor.setAccessible(false);
				}
			}
		}
	}

	private Object resolveValue(Parameter parameter, Map<String, Object> additional) {
		Object resolved;
		if (parameter.isAnnotationPresent(Named.class)) {
			String stringKey = parameter.getAnnotation(Named.class).value();
			resolved = resolveValue(stringKey, additional);
		} else {
			Class<?> type = parameter.getType();
			Class<?> classKey;
			if (type.isPrimitive()) {
				classKey = (Class<?>) PRIMITIVES_TO_WRAPPERS.get(type);
			} else {
				classKey = type;
			}
			resolved = resolveValue(classKey, additional);
		}
		return resolved;
	}

	private Object resolveValue(Field field, Map<String, Object> additional) {
		Object resolved;
		if (field.isAnnotationPresent(Named.class)) {
			String stringKey = field.getAnnotation(Named.class).value();
			resolved = resolveValue(stringKey, additional);
		} else {
			Class<?> type = field.getType();
			Class<?> classKey;
			if (type.isPrimitive()) {
				classKey = (Class<?>) PRIMITIVES_TO_WRAPPERS.get(type);
			} else {
				classKey = type;
			}
			resolved = resolveValue(classKey, additional);
		}
		return resolved;
	}

	private Object resolveValue(Class<?> classKey, Map<String, Object> additional) {
		if (additional != null) {
			Object fromAdditional = additional.get(classKey.getName());
			if (fromAdditional != null) {
				return fromAdditional;
			}
		}
		return container.get(classKey);
	}

	private Object resolveValue(String stringKey, Map<String, Object> additional) {
		if (additional != null) {
			Object fromAdditional = additional.get(stringKey);
			if (fromAdditional != null) {
				return fromAdditional;
			}
		}
		return container.get(stringKey);
	}
}
