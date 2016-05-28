package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class GoalDataPropertyFinishedEvent extends Event<OWLDataPropertyAssertionAxiom> {

	public GoalDataPropertyFinishedEvent(OWLDataPropertyAssertionAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_DATA_PROPERTY_FINISHED;
	}

}
