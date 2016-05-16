package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.EventType;

public class PlanFinishedEvent extends PlanBaseEvent {

	public PlanFinishedEvent(IPlan plan) {
		super(plan);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_FINISHED;
	}

}
