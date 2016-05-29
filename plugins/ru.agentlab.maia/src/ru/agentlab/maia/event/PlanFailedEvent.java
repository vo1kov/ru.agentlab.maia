package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;

public class PlanFailedEvent extends Event<IPlan> {

	public PlanFailedEvent(IPlan plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_FAILED;
	}

}
