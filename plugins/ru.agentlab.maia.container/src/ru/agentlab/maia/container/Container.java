/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.container;

import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;
import java.util.concurrent.atomic.AtomicReference;

import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.exception.ServiceNotFound;

/**
 * <p>
 * Implementation guarantee that:
 * <ul>
 * <li>Context can have parent;</li>
 * <li>Context have unique UUID;</li>
 * <li>Context redirect service searching to parent if can't find it;</li>
 * <li>Context disable <code>null</code> keys for storing services;</li>
 * </ul>
 * 
 * @author Dmitriy Shishkin
 */
public class Container implements IContainer {

	protected final String uuid = UUID.randomUUID().toString();

	protected final IInjector injector = new Injector(this);

	protected final AtomicReference<IContainer> parent = new AtomicReference<IContainer>(null);

	protected final Set<IContainer> childs = new ConcurrentSkipListSet<IContainer>();

	protected final Map<String, Object> map = new ConcurrentHashMap<String, Object>();

	@Override
	public String getUuid() {
		return uuid;
	}

	@Override
	public IContainer getParent() {
		return parent.get();
	}

	@Override
	public IInjector getInjector() {
		return injector;
	}

	@Override
	public Object get(String key) throws ServiceNotFound {
		check(key);

		Object result = map.get(key);
		if (result != null) {
			return result;
		}
		IContainer p = parent.get();
		if (p != null) {
			return p.get(key);
		} else {
			throw new ServiceNotFound("Service for key [" + key + "] did not found in context [" + toString()
					+ "] and all their parents");
		}
	}

	@Override
	public <T> T get(Class<T> key) throws ServiceNotFound {
		check(key);

		Object result = map.get(key);
		if (result != null) {
			return key.cast(result);
		}
		IContainer p = parent.get();
		if (p != null) {
			return p.get(key);
		} else {
			throw new ServiceNotFound("Service for key [" + key + "] did not found in context [" + toString()
					+ "] and all their parents");
		}
	}

	@Override
	public Object getLocal(String key) throws ServiceNotFound {
		check(key);
		Object result = map.get(key);
		if (result == null) {
			throw new ServiceNotFound();
		}
		return result;
	}

	@Override
	public Object getLocal(Class<?> key) {
		check(key);
		return map.get(key.getName());
	}

	@Override
	public Object put(String key, Object value) {
		check(key);
		return map.put(key, value);
	}

	@Override
	public <T extends Object> Object put(Class<T> key, T value) {
		check(key);
		return map.put(key.getName(), value);
	}

	@Override
	public Object remove(String key) {
		check(key);
		return map.remove(key);
	}

	@Override
	public Object remove(Class<?> key) {
		check(key);
		return map.remove(key.getName());
	}

	@Override
	public IContainer setParent(IContainer container) {
		return parent.getAndSet(container);
	}

	@Override
	public Iterable<IContainer> getChilds() {
		return childs;
	}

	@Override
	public void addChild(IContainer container) {
		childs.add(container);
		container.setParent(this);
	}

	@Override
	public void removeChild(IContainer container) {
		childs.remove(container);
		container.setParent(null);
	}

	@Override
	public void clearChilds() {
		childs.forEach(container -> container.setParent(null));
		childs.clear();
	}

	@Override
	public Set<String> getKeySet() {
		return map.keySet();
	}

	@Override
	public boolean clear() {
		map.clear();
		return true;
	}

	private void check(String key) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null");
		}
	}

	private void check(Class<?> key) {
		if (key == null) {
			throw new IllegalArgumentException("Key must be not null");
		}
	}

}