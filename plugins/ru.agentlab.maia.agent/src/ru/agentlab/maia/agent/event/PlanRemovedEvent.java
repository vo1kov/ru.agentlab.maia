package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IPlan;

public class PlanRemovedEvent extends AbstractPlanBaseEvent {

	public PlanRemovedEvent(IPlan plan) {
		super(plan);
	}

}
