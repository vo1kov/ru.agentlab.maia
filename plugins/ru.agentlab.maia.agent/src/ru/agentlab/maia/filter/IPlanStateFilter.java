package ru.agentlab.maia.filter;

import java.util.Map;

public interface IPlanStateFilter {

	boolean matches(Object item, Map<String, Object> values);

}
