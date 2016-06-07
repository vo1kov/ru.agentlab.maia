package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.EventType;

public class AddedClassAssertionEvent extends Event<OWLClassAssertionAxiom> {

	public AddedClassAssertionEvent(OWLClassAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.ADDED_CLASS_ASSERTION;
	}

}
