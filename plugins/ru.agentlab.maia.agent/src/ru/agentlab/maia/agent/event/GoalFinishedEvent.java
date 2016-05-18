package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IGoal;

public class GoalFinishedEvent extends AbstractGoalBaseEvent {

	public GoalFinishedEvent(IGoal goal) {
		super(goal);
	}

}
