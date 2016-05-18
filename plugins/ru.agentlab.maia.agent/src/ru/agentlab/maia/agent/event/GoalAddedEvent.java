package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IGoal;

public class GoalAddedEvent extends AbstractGoalBaseEvent {

	public GoalAddedEvent(IGoal goal) {
		super(goal);
	}

}
