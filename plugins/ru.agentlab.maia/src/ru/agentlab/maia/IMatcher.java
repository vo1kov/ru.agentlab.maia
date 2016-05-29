package ru.agentlab.maia;

import java.util.Map;

public interface IMatcher<T> {

	boolean match(T object, Map<String, Object> map);
	
	Class<T> getType();

}
