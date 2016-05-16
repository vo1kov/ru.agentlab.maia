package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IGoal;

public class GoalRemovedEvent extends AbstractGoalBaseEvent {

	public GoalRemovedEvent(IGoal goal) {
		super(goal);
	}

}
