package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.EventType;

public class BeliefDataPropertyAddedEvent extends Event<OWLClassAssertionAxiom> {

	public BeliefDataPropertyAddedEvent(OWLClassAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.BELIEF_DATA_PROPERTY_ADDED;
	}

}
