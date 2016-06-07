package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class RemovedDataPropertyAssertionEvent extends Event<OWLDataPropertyAssertionAxiom> {

	public RemovedDataPropertyAssertionEvent(OWLDataPropertyAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.REMOVED_DATA_PROPERTY_ASSERTION;
	}

}
