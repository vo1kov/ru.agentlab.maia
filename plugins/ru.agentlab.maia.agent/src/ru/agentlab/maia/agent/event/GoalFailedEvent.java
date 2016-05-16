package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IGoal;
import ru.agentlab.maia.agent.EventType;

public class GoalFailedEvent extends GoalBaseEvent {

	public GoalFailedEvent(IGoal goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_FAILED;
	}

}
