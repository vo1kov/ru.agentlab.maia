package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IGoal;

public class GoalObjectPropertyAddedEvent extends Event<IGoal> {

	public GoalObjectPropertyAddedEvent(IGoal goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_OBJECT_PROPERTY_ADDED;
	}

}
