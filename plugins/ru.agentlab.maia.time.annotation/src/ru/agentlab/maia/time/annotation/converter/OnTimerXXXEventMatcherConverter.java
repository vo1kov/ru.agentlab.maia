package ru.agentlab.maia.time.annotation.converter;

import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasProperty;
import static ru.agentlab.maia.match.EventMatchers.hamcrest;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.UUID;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.annotation.IEventMatcherConverter;

public class OnTimerXXXEventMatcherConverter implements IEventMatcherConverter {

	private static final String EVENT_KEY = "eventKey";

	@Override
	@SuppressWarnings("unchecked")
	public IEventMatcher<?> getMatcher(Object role, Method method, Annotation annotation,
			Map<String, Object> customData) {
		final UUID eventKey = UUID.randomUUID();
		customData.put(annotation.getClass().getName(), eventKey);
		return hamcrest(allOf(hasProperty(EVENT_KEY, equalTo(eventKey))));
	}

}