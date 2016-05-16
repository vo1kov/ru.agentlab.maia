package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.Event;

public abstract class AbstractPlanBaseEvent extends Event<IPlan> {

	public AbstractPlanBaseEvent(IPlan axiom) {
		super(axiom);
	}

}
