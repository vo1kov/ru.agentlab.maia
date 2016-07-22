package ru.agentlab.maia.role.annotation.converter;

import static org.hamcrest.CoreMatchers.anyOf;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.instanceOf;
import static ru.agentlab.maia.match.EventMatchers.hamcrest;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.annotation.IEventMatcherConverter;
import ru.agentlab.maia.annotation.Util;

public class OnRoleXXXConverter implements IEventMatcherConverter {

	@Override
	public IEventMatcher<?> getMatcher(Object role, Method method, Annotation annotation, Map<String, Object> customData) {
		Class<?> value = Util.getMethodValue(annotation, "value", Class.class);
		return hamcrest(anyOf(instanceOf(value), equalTo(value)));
	}
}
