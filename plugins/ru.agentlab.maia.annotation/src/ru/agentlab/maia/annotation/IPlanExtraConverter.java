package ru.agentlab.maia.annotation;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Map;

import com.google.common.collect.Multimap;

import ru.agentlab.maia.agent.IPlan;

public interface IPlanExtraConverter {

	Multimap<Class<?>, IPlan> getPlans(Object role, Method method, Annotation annotation,
			Map<String, Object> customData);

}