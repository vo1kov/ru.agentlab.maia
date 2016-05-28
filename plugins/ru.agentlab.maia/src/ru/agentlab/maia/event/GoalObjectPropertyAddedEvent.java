package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class GoalObjectPropertyAddedEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public GoalObjectPropertyAddedEvent(OWLObjectPropertyAssertionAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_OBJECT_PROPERTY_ADDED;
	}

}
