package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;

public class PlanAddedEvent extends Event<IPlan> {

	public PlanAddedEvent(IPlan plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_ADDED;
	}

}
