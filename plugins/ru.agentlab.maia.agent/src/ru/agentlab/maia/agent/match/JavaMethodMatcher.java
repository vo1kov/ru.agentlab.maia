package ru.agentlab.maia.agent.match;

import java.lang.reflect.Method;
import java.util.Map;

import ru.agentlab.maia.IMatcher;

public class JavaMethodMatcher implements IMatcher<Method> {

	Method value;

	public JavaMethodMatcher(Method clazz) {
		this.value = clazz;
	}

	@Override
	public boolean match(Method method, Map<String, Object> map) {
		return method == value;
	}

	@Override
	public Class<Method> getType() {
		return Method.class;
	}

}
