package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IGoal;

public class GoalObjectPropertyRemovedEvent extends Event<IGoal> {

	public GoalObjectPropertyRemovedEvent(IGoal goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_OBJECT_PROPERTY_REMOVED;
	}

}
