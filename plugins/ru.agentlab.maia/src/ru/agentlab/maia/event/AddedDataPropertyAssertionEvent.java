package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class AddedDataPropertyAssertionEvent extends Event<OWLDataPropertyAssertionAxiom> {

	public AddedDataPropertyAssertionEvent(OWLDataPropertyAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.ADDED_DATA_PROPERTY_ASSERTION;
	}

}
