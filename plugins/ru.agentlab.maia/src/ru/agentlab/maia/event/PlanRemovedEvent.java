package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;

public class PlanRemovedEvent extends Event<IPlan> {

	public PlanRemovedEvent(IPlan plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_REMOVED;
	}

}
