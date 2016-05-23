package ru.agentlab.maia.agent.match;

import java.util.Map;

public class JavaStringMatcher implements IMatcher<String> {

	String value;

	public JavaStringMatcher(String clazz) {
		this.value = clazz;
	}

	@Override
	public boolean match(String string, Map<String, Object> map) {
		return string.equals(value);
	}

	@Override
	public Class<?> getType() {
		return String.class;
	}

}
