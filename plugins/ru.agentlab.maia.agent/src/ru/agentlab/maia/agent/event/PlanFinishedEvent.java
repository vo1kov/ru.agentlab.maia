package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IPlan;

public class PlanFinishedEvent extends AbstractPlanBaseEvent {

	public PlanFinishedEvent(IPlan plan) {
		super(plan);
	}

}
