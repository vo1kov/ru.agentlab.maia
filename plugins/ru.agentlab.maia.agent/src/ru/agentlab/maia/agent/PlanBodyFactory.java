package ru.agentlab.maia.agent;

import java.lang.reflect.Method;

import ru.agentlab.maia.IPlanBody;

public class PlanBodyFactory {

	public static IPlanBody create(Object role, Method method) {
		if (method.getParameterCount() == 0) {
			return new PlanBodyStateles(role, method);
		} else {
			return new PlanBodyStateful(role, method);
		}
	}

	public static IPlanBody create(Object role, Runnable runnable) {
		return new PlanBodyLambda(runnable);
	}

}
