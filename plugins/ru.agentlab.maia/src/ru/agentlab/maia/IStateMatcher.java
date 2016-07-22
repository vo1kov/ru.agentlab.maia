package ru.agentlab.maia;

import java.util.Map;

public interface IStateMatcher {

	boolean matches(Object item, Map<String, Object> values);

}
