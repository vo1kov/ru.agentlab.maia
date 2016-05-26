package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class BeliefObjectPropertyAddedEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public BeliefObjectPropertyAddedEvent(OWLObjectPropertyAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.BELIEF_OBJECT_PROPERTY_ADDED;
	}

}
