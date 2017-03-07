package ru.agentlab.maia.agent.annotation.converter;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;

import ru.agentlab.maia.agent.converter.IPlanEventFilterConverter;
import ru.agentlab.maia.agent.filter.IPlanEventFilter;
import ru.agentlab.maia.agent.filter.impl.PlanEventFilters;

public class GenericEventFilterConverter implements IPlanEventFilterConverter {

	@Override
	public IPlanEventFilter<?> getMatcher(Object role, Method method, Annotation annotation,
			Map<String, Object> customData) {
		return PlanEventFilters.anything();
	}
}
