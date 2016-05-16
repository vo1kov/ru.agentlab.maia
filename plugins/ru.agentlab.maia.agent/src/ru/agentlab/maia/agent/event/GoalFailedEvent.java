package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IGoal;

public class GoalFailedEvent extends AbstractGoalBaseEvent {

	public GoalFailedEvent(IGoal goal) {
		super(goal);
	}

}
