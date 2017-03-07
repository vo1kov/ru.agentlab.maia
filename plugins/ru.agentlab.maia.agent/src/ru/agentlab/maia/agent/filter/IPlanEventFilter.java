package ru.agentlab.maia.agent.filter;

import java.util.Map;

@FunctionalInterface
public interface IPlanEventFilter<T> {

	boolean matches(Object event, Map<String, Object> values);

}
