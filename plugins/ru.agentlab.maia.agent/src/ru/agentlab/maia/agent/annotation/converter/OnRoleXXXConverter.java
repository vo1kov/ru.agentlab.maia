package ru.agentlab.maia.agent.annotation.converter;

import static org.hamcrest.CoreMatchers.anyOf;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.instanceOf;
import static ru.agentlab.maia.agent.filter.impl.PlanEventFilters.hamcrest;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;

import ru.agentlab.maia.agent.converter.IPlanEventFilterConverter;
import ru.agentlab.maia.agent.converter.Util;
import ru.agentlab.maia.agent.filter.IPlanEventFilter;

public class OnRoleXXXConverter implements IPlanEventFilterConverter {

	@Override
	public IPlanEventFilter<?> getMatcher(Object role, Method method, Annotation annotation,
			Map<String, Object> customData) {
		Class<?> value = Util.getMethodActualValue(annotation, "value", Class.class);
		return hamcrest(anyOf(instanceOf(value), equalTo(value)));
	}
}
