package ru.agentlab.maia.time.annotation.converter;

import static org.hamcrest.CoreMatchers.allOf;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.Matchers.hasProperty;
import static ru.agentlab.maia.filter.impl.PlanEventFilters.hamcrest;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.UUID;

import ru.agentlab.maia.converter.IPlanEventFilterConverter;
import ru.agentlab.maia.filter.IPlanEventFilter;

public class OnTimerXXXEventMatcherConverter implements IPlanEventFilterConverter {

	private static final String EVENT_KEY = "eventKey";

	@Override
	@SuppressWarnings("unchecked")
	public IPlanEventFilter<?> getMatcher(Object role, Method method, Annotation annotation,
			Map<String, Object> customData) {
		final UUID eventKey = UUID.randomUUID();
		customData.put(annotation.getClass().getName(), eventKey);
		return hamcrest(allOf(hasProperty(EVENT_KEY, equalTo(eventKey))));
	}

}