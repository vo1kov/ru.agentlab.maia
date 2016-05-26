package ru.agentlab.maia.agent;

import java.util.Queue;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IGoal;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.event.GoalClassificationAddedEvent;

public class GoalBase implements IGoalBase {

	private final Queue<IEvent<?>> eventQueue;

	public GoalBase(Queue<IEvent<?>> eventQueue) {
		this.eventQueue = eventQueue;
	}

	@Override
	public IGoal addGoal(String string) {
		Goal goal = new Goal(string);
		eventQueue.offer(new GoalClassificationAddedEvent(goal));
		return null;
	}

	@Override
	public boolean removeGoal(String property) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void addAxiom(OWLAxiom axiom) {
		// TODO Auto-generated method stub
		
	}

}
