package ru.agentlab.maia.agent.match;

import java.util.Map;

public interface IMatcher<T> {

	boolean match(T object, Map<String, Object> map);
	
	Class<?> getType();

}
