package ru.agentlab.maia;

import java.util.Map;

@FunctionalInterface
public interface IEventMatcher {

	boolean matches(Object event, Map<String, Object> values);

}
