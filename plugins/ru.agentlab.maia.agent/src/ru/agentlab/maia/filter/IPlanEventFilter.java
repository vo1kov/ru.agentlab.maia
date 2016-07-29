package ru.agentlab.maia.filter;

import java.util.Map;

@FunctionalInterface
public interface IPlanEventFilter<T> {

	boolean matches(Object event, Map<String, Object> values);

}
