package ru.agentlab.maia.event;

import java.lang.reflect.Method;

import ru.agentlab.maia.EventType;

public class PlanAddedEvent extends Event<Method> {

	public PlanAddedEvent(Method plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_ADDED;
	}

}
