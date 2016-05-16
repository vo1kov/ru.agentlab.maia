package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IGoal;
import ru.agentlab.maia.agent.EventType;

public class GoalFinishedEvent extends GoalBaseEvent {

	public GoalFinishedEvent(IGoal goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_FINISHED;
	}

}
