package ru.agentlab.maia.annotation;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;

import ru.agentlab.maia.IEventMatcher;

public interface IEventMatcherConverter {

	IEventMatcher<?> getMatcher(Object role, Method method, Annotation annotation, Map<String, Object> customData);

}