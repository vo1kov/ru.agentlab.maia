package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IPlan;

public class PlanAddedEvent extends AbstractPlanBaseEvent {

	public PlanAddedEvent(IPlan plan) {
		super(plan);
	}

}
