package ru.agentlab.maia.agent.annotation.converter;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;

import ru.agentlab.maia.converter.IPlanEventFilterConverter;
import ru.agentlab.maia.filter.IPlanEventFilter;
import ru.agentlab.maia.filter.impl.PlanEventFilters;

public class GenericEventFilterConverter implements IPlanEventFilterConverter {

	@Override
	public IPlanEventFilter<?> getMatcher(Object role, Method method, Annotation annotation,
			Map<String, Object> customData) {
		return PlanEventFilters.anything();
	}
}
