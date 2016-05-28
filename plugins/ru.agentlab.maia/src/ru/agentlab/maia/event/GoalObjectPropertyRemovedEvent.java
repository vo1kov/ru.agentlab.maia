package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class GoalObjectPropertyRemovedEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public GoalObjectPropertyRemovedEvent(OWLObjectPropertyAssertionAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.GOAL_OBJECT_PROPERTY_REMOVED;
	}

}
