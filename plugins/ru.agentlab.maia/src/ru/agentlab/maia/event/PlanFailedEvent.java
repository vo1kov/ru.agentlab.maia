package ru.agentlab.maia.event;

import java.lang.reflect.Method;

import ru.agentlab.maia.EventType;

public class PlanFailedEvent extends Event<Method> {

	public PlanFailedEvent(Method plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_FAILED;
	}

}
