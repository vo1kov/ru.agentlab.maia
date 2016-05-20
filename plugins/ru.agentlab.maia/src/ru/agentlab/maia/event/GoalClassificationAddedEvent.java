package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IGoal;

public class GoalClassificationAddedEvent extends Event<IGoal> {

	public GoalClassificationAddedEvent(IGoal goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_CLASSIFICATION_ADDED;
	}

}
