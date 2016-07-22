package ru.agentlab.maia;

import java.util.Map;

@FunctionalInterface
public interface IEventMatcher<T> {

	boolean matches(Object event, Map<String, Object> values);

}
