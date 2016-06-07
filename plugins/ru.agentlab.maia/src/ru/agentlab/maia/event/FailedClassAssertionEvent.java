package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.EventType;

public class FailedClassAssertionEvent extends Event<OWLClassAssertionAxiom> {

	public FailedClassAssertionEvent(OWLClassAssertionAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.FAILED_CLASS_ASSERTION;
	}

}
