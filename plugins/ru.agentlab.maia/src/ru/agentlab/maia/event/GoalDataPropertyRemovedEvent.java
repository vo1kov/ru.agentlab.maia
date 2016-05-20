package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IGoal;

public class GoalDataPropertyRemovedEvent extends Event<IGoal> {

	public GoalDataPropertyRemovedEvent(IGoal goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_DATA_PROPERTY_REMOVED;
	}

}
