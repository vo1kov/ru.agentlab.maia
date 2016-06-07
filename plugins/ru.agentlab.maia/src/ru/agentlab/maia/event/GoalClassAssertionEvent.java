package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.EventType;

public class GoalClassAssertionEvent extends Event<OWLClassAssertionAxiom> {

	public GoalClassAssertionEvent(OWLClassAssertionAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_CLASS_ASSERTION;
	}

}
