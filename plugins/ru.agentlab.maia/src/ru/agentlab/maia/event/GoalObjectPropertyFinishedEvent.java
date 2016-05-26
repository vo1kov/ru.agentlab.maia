package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IGoal;

public class GoalObjectPropertyFinishedEvent extends Event<IGoal> {

	public GoalObjectPropertyFinishedEvent(IGoal goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_OBJECT_PROPERTY_FINISHED;
	}

}
