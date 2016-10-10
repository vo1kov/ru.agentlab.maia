package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;

public class GoalAddedEvent extends Event<Object> {

	public GoalAddedEvent(Object goal) {
		super(goal);
	}

}
