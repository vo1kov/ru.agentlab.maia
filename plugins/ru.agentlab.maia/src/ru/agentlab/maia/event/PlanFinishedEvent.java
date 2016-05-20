package ru.agentlab.maia.event;

import java.lang.reflect.Method;

import ru.agentlab.maia.EventType;

public class PlanFinishedEvent extends Event<Method> {

	public PlanFinishedEvent(Method plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_FINISHED;
	}

}
