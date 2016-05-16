package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.EventType;

public class PlanRemovedEvent extends PlanBaseEvent {

	public PlanRemovedEvent(IPlan plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_REMOVED;
	}

}
