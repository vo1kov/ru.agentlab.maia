package ru.agentlab.maia.agent.annotation;

import ru.agentlab.maia.Event;
import ru.agentlab.maia.IGoal;

public class OnGoalSuccess extends Event<IGoal> {

	public OnGoalSuccess(IGoal payload) {
		super(payload);
	}

}
