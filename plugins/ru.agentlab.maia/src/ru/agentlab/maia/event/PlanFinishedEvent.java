package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;

public class PlanFinishedEvent extends Event<IPlan> {

	public PlanFinishedEvent(IPlan plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_FINISHED;
	}

}
