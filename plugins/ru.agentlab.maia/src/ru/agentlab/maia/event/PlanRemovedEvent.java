package ru.agentlab.maia.event;

import java.lang.reflect.Method;

import ru.agentlab.maia.EventType;

public class PlanRemovedEvent extends Event<Method> {

	public PlanRemovedEvent(Method plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_REMOVED;
	}

}
