package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class RemovedObjectPropertyAssertionEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public RemovedObjectPropertyAssertionEvent(OWLObjectPropertyAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.REMOVED_OBJECT_PROPERTY_ASSERTION;
	}

}
