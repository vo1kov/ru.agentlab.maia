package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class GoalDataPropertyAddedEvent extends Event<OWLDataPropertyAssertionAxiom> {

	public GoalDataPropertyAddedEvent(OWLDataPropertyAssertionAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_DATA_PROPERTY_ADDED;
	}

}
