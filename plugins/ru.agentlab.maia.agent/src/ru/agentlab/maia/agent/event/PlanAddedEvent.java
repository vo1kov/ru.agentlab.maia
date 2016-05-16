package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.EventType;

public class PlanAddedEvent extends PlanBaseEvent {

	public PlanAddedEvent(IPlan plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_ADDED;
	}

}
