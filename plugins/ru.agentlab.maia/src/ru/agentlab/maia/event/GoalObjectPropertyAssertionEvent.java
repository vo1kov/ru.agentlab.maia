package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class GoalObjectPropertyAssertionEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public GoalObjectPropertyAssertionEvent(OWLObjectPropertyAssertionAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_OBJECT_PROPERTY_ASSERTION;
	}

}
