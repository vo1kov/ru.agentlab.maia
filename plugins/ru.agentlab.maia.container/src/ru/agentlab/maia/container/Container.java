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

import java.util.Collection;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IInjector;

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
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
public class Container extends AbstractContainer {

	protected final Map<String, Object> map = new ConcurrentHashMap<String, Object>();

	{
		map.put(IContainer.class.getName(), this);
		map.put(Container.class.getName(), this);
		map.put(IInjector.class.getName(), injector);
		map.put(Injector.class.getName(), injector);
	}

	@Override
	public boolean clear() {
		map.clear();
		return true;
	}

	@Override
	public Set<Object> getKeySet() {
		Set<Object> result = new HashSet<>();
		result.addAll(map.keySet());
		return result;
	}

	@Override
	public Object getLocal(String key) {
		checkNotNull(key);
		Object result = map.get(key);
		return result;
	}

	@Override
	public Object put(String key, Object value) {
		checkNotNull(key);
		return map.put(key, value);
	}

	@Override
	public Object remove(Object service) {
		checkNotNull(service, "Service should be non null");
		return map.remove(service.getClass());
	}

	@Override
	public Object remove(String key) {
		checkNotNull(key);
		return map.remove(key);
	}

	@Override
	public Collection<Object> values() {
		return map.values();
	}

}