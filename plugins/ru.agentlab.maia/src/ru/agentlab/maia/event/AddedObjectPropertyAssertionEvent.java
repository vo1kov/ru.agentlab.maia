package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class AddedObjectPropertyAssertionEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public AddedObjectPropertyAssertionEvent(OWLObjectPropertyAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.ADDED_OBJECT_PROPERTY_ASSERTION;
	}

}
