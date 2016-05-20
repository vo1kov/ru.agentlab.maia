/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.match;

import java.util.HashMap;
import java.util.Map;

public class Unifier implements IUnifier {

	Map<String, Object> values = new HashMap<String, Object>();

	@Override
	public Object get(String key) {
		return values.get(key);
	}

	@Override
	public Object put(String key, Object value) {
		return values.put(key, value);
	}

	@Override
	public void remove(String key) {
		values.remove(key);
	}

}
