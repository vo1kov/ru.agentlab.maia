package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class FailedDataPropertyAssertionEvent extends Event<OWLDataPropertyAssertionAxiom> {

	public FailedDataPropertyAssertionEvent(OWLDataPropertyAssertionAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.FAILED_DATA_PROPERTY_ASSERTION;
	}

}
