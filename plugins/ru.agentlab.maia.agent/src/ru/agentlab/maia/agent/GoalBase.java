package ru.agentlab.maia.agent;

import java.util.Queue;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.agent.goal.event.GoalAddedEvent;

public class GoalBase implements IGoalBase {

	private final Queue<IEvent<?>> eventQueue;

	public GoalBase(Queue<IEvent<?>> eventQueue) {
		this.eventQueue = eventQueue;
	}

	@Override
	public boolean addGoal(OWLAxiom axiom) {
		// TODO: implement this
		eventQueue.offer(new GoalAddedEvent(axiom));
		return false;
	}

	@Override
	public boolean removeGoal(OWLAxiom axiom) {
		// TODO Auto-generated method stub
		// eventQueue.offer(new GoalClassificationRemovedEvent(axiom));
		return false;
	}

}
