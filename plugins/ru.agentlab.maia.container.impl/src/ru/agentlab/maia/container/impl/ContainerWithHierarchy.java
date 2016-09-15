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

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.lang.ClassUtils;

import com.google.common.collect.LinkedHashMultimap;
import com.google.common.collect.Multimap;
import com.google.common.collect.Multimaps;

/**
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
public class ContainerWithHierarchy extends AbstractContainer {

	protected final Multimap<Class<?>, Object> valuesBySuperClass = Multimaps
		.synchronizedSetMultimap(LinkedHashMultimap.create());

	protected final Map<Class<?>, Object> valuesByClass = new ConcurrentHashMap<>();

	protected final Map<String, Object> valuesByString = new ConcurrentHashMap<>();

	{
		put(this);
		put(injector);
	}

	@Override
	public Object getLocal(String key) {
		checkNotNull(key, "Key string should be non null");
		return valuesByString.get(key);
	}

	@Override
	@SuppressWarnings("unchecked")
	public <T> T getLocal(Class<T> key) {
		checkNotNull(key, "Key class should be non null");
		Object service = valuesByClass.get(key);
		if (service == null) {
			Iterator<Object> iterator = valuesBySuperClass.get(key).iterator();
			if (iterator.hasNext()) {
				return (T) iterator.next();
			} else {
				return null;
			}
		} else {
			return (T) service;
		}
	}

	@Override
	public Object put(String key, Object value) {
		checkNotNull(key, "Key string should be non null");
		return valuesByString.put(key, value);
	}

	@Override
	@SuppressWarnings("unchecked")
	public <T> T put(Class<? super T> key, T service) {
		checkNotNull(key, "Key class should be non null");
		checkNotNull(service, "Service should be non null");
		List<Class<?>> superinterfaces = ClassUtils.getAllInterfaces(key);
		List<Class<?>> superclasses = ClassUtils.getAllSuperclasses(key);
		valuesByClass.put(key, service);
		valuesBySuperClass.put(key, service);
		superinterfaces.stream().forEach(superinterface -> valuesBySuperClass.put(superinterface, service));
		superclasses.stream().filter(superinterface -> superinterface != Object.class).forEach(
			superclass -> valuesBySuperClass.put(superclass, service));

		return service;
	}

	@Override
	@SuppressWarnings("unchecked")
	public Object put(Object service) {
		checkNotNull(service, "Service should be non null");
		Class<? extends Object> key = service.getClass();
		List<Class<?>> superinterfaces = ClassUtils.getAllInterfaces(key);
		List<Class<?>> superclasses = ClassUtils.getAllSuperclasses(key);
		valuesByClass.put(key, service);
		valuesBySuperClass.put(key, service);
		superinterfaces.stream().forEach(superinterface -> valuesBySuperClass.put(superinterface, service));
		superclasses.stream().filter(superinterface -> superinterface != Object.class).forEach(
			superclass -> valuesBySuperClass.put(superclass, service));
		return service;
	}

	@Override
	public Object remove(String key) {
		checkNotNull(key, "Key string should be non null");
		return valuesByString.remove(key);
	}

	@Override
	@SuppressWarnings("unchecked")
	public Object remove(Object service) {
		checkNotNull(service, "Service should be non null");
		Class<? extends Object> clazz = service.getClass();
		List<Class<?>> superinterfaces = ClassUtils.getAllInterfaces(clazz);
		List<Class<?>> superclasses = ClassUtils.getAllSuperclasses(clazz);
		valuesByClass.remove(clazz, service);
		valuesBySuperClass.remove(clazz, service);
		superinterfaces.stream().forEach(superinterface -> {
			valuesBySuperClass.remove(superinterface, service);
			valuesByClass.remove(superinterface, service);
		});
		superclasses.stream().forEach(superclass -> {
			valuesBySuperClass.remove(superclass, service);
			valuesByClass.remove(superclass, service);
		});
		return null;
	}

	@Override
	public Object remove(Class<?> key) {
		checkNotNull(key, "Key class should be non null");
		valuesByClass.remove(key);
		return valuesBySuperClass.removeAll(key);
	}

	@Override
	public Set<Object> getKeySet() {
		Set<Object> result = new HashSet<>();
		result.addAll(valuesByString.keySet());
		result.addAll(valuesBySuperClass.keySet());
		return result;
	}

	@Override
	public Collection<Object> values() {
		Set<Object> result = new HashSet<>();
		result.addAll(valuesByString.values());
		result.addAll(valuesBySuperClass.values());
		return result;
	}

	@Override
	public boolean clear() {
		valuesByString.clear();
		valuesBySuperClass.clear();
		return true;
	}

}