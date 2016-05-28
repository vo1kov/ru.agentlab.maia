package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class GoalObjectPropertyFinishedEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public GoalObjectPropertyFinishedEvent(OWLObjectPropertyAssertionAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_OBJECT_PROPERTY_FINISHED;
	}

}
