package ru.agentlab.maia.agent.match.event;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.match.IEventMatcher;

public class PlanBaseEventMatcher implements IEventMatcher<IPlan> {

	@Override
	public boolean match(IPlan payload) {
		return false;
	}

}
