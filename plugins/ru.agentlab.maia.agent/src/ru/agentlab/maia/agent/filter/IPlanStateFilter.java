package ru.agentlab.maia.agent.filter;

import java.util.Map;

public interface IPlanStateFilter {

	boolean matches(Object item, Map<String, Object> values);

}
