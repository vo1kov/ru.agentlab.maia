package ru.agentlab.maia.agent;

import java.util.Queue;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IGoal;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.agent.event.GoalAddedEvent;

public class GoalBase implements IGoalBase {

	private final Queue<IEvent<?>> eventQueue;

	public GoalBase(Queue<IEvent<?>> eventQueue) {
		this.eventQueue = eventQueue;
	}

	@Override
	public IGoal addGoal(String string) {
		Goal goal = new Goal(string);
		eventQueue.offer(new GoalAddedEvent(goal));
		return null;
	}

	@Override
	public boolean removeGoal(String property) {
		// TODO Auto-generated method stub
		return false;
	}

}
