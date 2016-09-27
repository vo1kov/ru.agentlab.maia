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
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import org.apache.commons.lang3.ClassUtils;

import com.google.common.collect.LinkedHashMultimap;
import com.google.common.collect.Multimap;

/**
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
public class ContainerWithHierarchy extends AbstractContainer {

	protected final Multimap<Class<?>, Object> valuesBySuperClass = LinkedHashMultimap.create();

	protected final Map<Class<?>, Object> valuesByClass = new HashMap<>();

	protected final Map<String, Object> valuesByString = new ConcurrentHashMap<>();

	private final ReadWriteLock lock = new ReentrantReadWriteLock();

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
		lock.readLock().lock();
		T result;
		Object service = valuesByClass.get(key);
		if (service == null) {
			Iterator<Object> iterator = valuesBySuperClass.get(key).iterator();
			if (iterator.hasNext()) {
				result = (T) iterator.next();
			} else {
				result = null;
			}
		} else {
			result = (T) service;
		}
		lock.readLock().unlock();
		return result;
	}

	@Override
	public Object put(String key, Object value) {
		checkNotNull(key, "Key string should be non null");
		return valuesByString.put(key, value);
	}

	@Override
	public <T> T put(Class<? super T> key, T service) {
		checkNotNull(key, "Key class should be non null");
		checkNotNull(service, "Service should be non null");
		List<Class<?>> superinterfaces = ClassUtils.getAllInterfaces(key);
		List<Class<?>> superclasses = ClassUtils.getAllSuperclasses(key);
		lock.writeLock().lock();
		valuesByClass.put(key, service);
		valuesBySuperClass.put(key, service);
		superinterfaces.stream().forEach(superinterface -> valuesBySuperClass.put(superinterface, service));
		superclasses.stream().filter(superinterface -> superinterface != Object.class).forEach(
			superclass -> valuesBySuperClass.put(superclass, service));
		lock.writeLock().unlock();
		return service;
	}

	@Override
	public Object put(Object service) {
		checkNotNull(service, "Service should be non null");
		Class<? extends Object> key = service.getClass();
		List<Class<?>> superinterfaces = ClassUtils.getAllInterfaces(key);
		List<Class<?>> superclasses = ClassUtils.getAllSuperclasses(key);
		lock.writeLock().lock();
		valuesByClass.put(key, service);
		valuesBySuperClass.put(key, service);
		superinterfaces.stream().forEach(superinterface -> valuesBySuperClass.put(superinterface, service));
		superclasses.stream().filter(superinterface -> superinterface != Object.class).forEach(
			superclass -> valuesBySuperClass.put(superclass, service));
		lock.writeLock().unlock();
		return service;
	}

	@Override
	public Object remove(String key) {
		checkNotNull(key, "Key string should be non null");
		return valuesByString.remove(key);
	}

	@Override
	public Object remove(Object service) {
		checkNotNull(service, "Service should be non null");
		Class<? extends Object> clazz = service.getClass();
		List<Class<?>> superinterfaces = ClassUtils.getAllInterfaces(clazz);
		List<Class<?>> superclasses = ClassUtils.getAllSuperclasses(clazz);
		lock.writeLock().lock();
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
		lock.writeLock().unlock();
		return null;
	}

	@Override
	public Object remove(Class<?> key) {
		checkNotNull(key, "Key class should be non null");
		lock.writeLock().lock();
		valuesByClass.remove(key);
		valuesBySuperClass.removeAll(key);
		lock.writeLock().unlock();
		return null;
	}

	@Override
	public Set<Object> getKeySet() {
		Set<Object> result = new HashSet<>();
		lock.readLock().lock();
		result.addAll(valuesByClass.keySet());
		result.addAll(valuesBySuperClass.keySet());
		lock.readLock().unlock();
		result.addAll(valuesByString.keySet());
		return result;
	}

	@Override
	public Collection<Object> values() {
		Set<Object> result = new HashSet<>();
		lock.readLock().lock();
		result.addAll(valuesByClass.values());
		result.addAll(valuesBySuperClass.values());
		lock.readLock().unlock();
		result.addAll(valuesByString.values());
		return result;
	}

	@Override
	public boolean clear() {
		lock.writeLock().lock();
		valuesByClass.clear();
		valuesBySuperClass.clear();
		lock.writeLock().unlock();
		valuesByString.clear();
		return true;
	}

}