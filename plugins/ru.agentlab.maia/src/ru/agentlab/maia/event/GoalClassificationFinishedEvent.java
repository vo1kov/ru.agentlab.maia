package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.EventType;

public class GoalClassificationFinishedEvent extends Event<OWLClassAssertionAxiom> {

	public GoalClassificationFinishedEvent(OWLClassAssertionAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_CLASSIFICATION_FINISHED;
	}

}
