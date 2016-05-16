package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IGoal;
import ru.agentlab.maia.agent.Event;

public abstract class GoalBaseEvent extends Event<IGoal> {

	public GoalBaseEvent(IGoal goal) {
		super(goal);
	}

}
