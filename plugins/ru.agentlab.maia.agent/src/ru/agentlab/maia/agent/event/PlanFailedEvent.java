package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IPlan;

public class PlanFailedEvent extends AbstractPlanBaseEvent {

	public PlanFailedEvent(IPlan plan) {
		super(plan);
	}

}
