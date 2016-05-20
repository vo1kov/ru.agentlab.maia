package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IGoal;

public class GoalDataPropertyFailedEvent extends Event<IGoal> {

	public GoalDataPropertyFailedEvent(IGoal goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_DATA_PROPERTY_FAILED;
	}

}
