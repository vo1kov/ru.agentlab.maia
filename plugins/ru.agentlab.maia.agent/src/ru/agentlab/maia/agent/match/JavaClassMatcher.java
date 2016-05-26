package ru.agentlab.maia.agent.match;

import java.util.Map;

public class JavaClassMatcher implements IMatcher<Class<?>> {

	Class<?> value;

	public JavaClassMatcher(Class<?> clazz) {
		this.value = clazz;
	}

	@Override
	public boolean match(Class<?> clazz, Map<String, Object> map) {
		return clazz == value;
	}

	@Override
	public Class<?> getType() {
		return Class.class;
	}

}
