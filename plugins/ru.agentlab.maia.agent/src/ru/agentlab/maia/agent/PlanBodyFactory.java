package ru.agentlab.maia.agent;

import java.lang.reflect.Method;

import ru.agentlab.maia.IPlanBody;

public class PlanBodyFactory {

	public static IPlanBody create(Object role, Method method) {
		if (method.getParameterCount() == 0) {
			return new PlanStateles(role, method);
		} else {
			return new PlanStateful(role, method);
		}
	}

	public static IPlanBody create(Object role, Runnable runnable) {
		return new PlanLambda(runnable);
	}

}
