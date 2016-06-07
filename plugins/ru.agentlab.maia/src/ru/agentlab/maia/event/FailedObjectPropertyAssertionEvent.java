package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class FailedObjectPropertyAssertionEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public FailedObjectPropertyAssertionEvent(OWLObjectPropertyAssertionAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.FAILED_OBJECT_PROPERTY_ASSERTION;
	}

}
