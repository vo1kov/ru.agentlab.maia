package ru.agentlab.maia.agent;

import java.util.Map;

public interface IStateMatcher {

	boolean matches(Object item, Map<String, Object> values);

}
