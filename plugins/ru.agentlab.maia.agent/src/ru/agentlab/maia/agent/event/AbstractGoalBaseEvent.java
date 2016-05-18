package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IGoal;
import ru.agentlab.maia.agent.Event;

public abstract class AbstractGoalBaseEvent extends Event<IGoal> {

	public AbstractGoalBaseEvent(IGoal goal) {
		super(goal);
	}

}
