package ru.agentlab.maia;

import java.util.Map;

public interface IPlanFilter {

	boolean matches(Object item, Map<String, Object> values);

}
