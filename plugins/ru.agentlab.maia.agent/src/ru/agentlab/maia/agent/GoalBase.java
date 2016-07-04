package ru.agentlab.maia.agent;

import java.util.Queue;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.event.AddedGoalEvent;

public class GoalBase implements IGoalBase {

	private final Queue<IEvent<?>> eventQueue;

	public GoalBase(Queue<IEvent<?>> eventQueue) {
		this.eventQueue = eventQueue;
	}

	@Override
	public boolean addGoalClassAsertion(OWLClassAssertionAxiom axiom) {
		// TODO: implement this
		eventQueue.offer(new AddedGoalEvent(axiom));
		return false;
	}

	@Override
	public boolean addGoalDataPropertyAsertion(OWLDataPropertyAssertionAxiom axiom) {
		// TODO: implement this
		eventQueue.offer(new AddedGoalEvent(axiom));
		return false;
	}

	@Override
	public boolean addGoalObjectPropertyAsertion(OWLObjectPropertyAssertionAxiom axiom) {
		// TODO: implement this
		eventQueue.offer(new AddedGoalEvent(axiom));
		return false;
	}

	@Override
	public boolean removeGoalClassAsertion(OWLClassAssertionAxiom axiom) {
		// TODO Auto-generated method stub
		// eventQueue.offer(new GoalClassificationRemovedEvent(axiom));
		return false;
	}

	@Override
	public boolean removeGoalDataPropertyAsertion(OWLDataPropertyAssertionAxiom axiom) {
		// TODO Auto-generated method stub
		// eventQueue.offer(new GoalDataPropertyRemovedEvent(axiom));
		return false;
	}

	@Override
	public boolean removeObjectPropertyAsertion(OWLObjectPropertyAssertionAxiom axiom) {
		// TODO Auto-generated method stub
		// eventQueue.offer(new GoalObjectPropertyRemovedEvent(axiom));
		return false;
	}

}
