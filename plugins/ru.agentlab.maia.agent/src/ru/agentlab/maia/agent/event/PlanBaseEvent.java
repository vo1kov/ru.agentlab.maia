package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.Event;

public abstract class PlanBaseEvent extends Event<IPlan> {

	public PlanBaseEvent(IPlan axiom) {
		super(axiom);
	}

}
