package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.EventType;

public class RemovedClassAssertionEvent extends Event<OWLClassAssertionAxiom> {

	public RemovedClassAssertionEvent(OWLClassAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.REMOVED_CLASS_ASSERTION;
	}

}
