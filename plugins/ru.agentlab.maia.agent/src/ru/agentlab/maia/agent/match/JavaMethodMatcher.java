package ru.agentlab.maia.agent.match;

import java.lang.reflect.Method;

public class JavaMethodMatcher implements IMatcher<Method> {

	Method value;

	public JavaMethodMatcher(Method clazz) {
		this.value = clazz;
	}

	@Override
	public boolean match(Method method, IUnifier unifier) {
		return method == value;
	}

	@Override
	public Class<?> getType() {
		return Method.class;
	}

}
