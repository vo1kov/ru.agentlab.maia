package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.EventType;

public class PlanFailedEvent extends PlanBaseEvent {

	public PlanFailedEvent(IPlan plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_FAILED;
	}

}
