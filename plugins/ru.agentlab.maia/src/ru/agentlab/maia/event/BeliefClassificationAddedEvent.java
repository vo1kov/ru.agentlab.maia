package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.EventType;

public class BeliefClassificationAddedEvent extends Event<OWLClassAssertionAxiom> {

	public BeliefClassificationAddedEvent(OWLClassAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.BELIEF_CLASSIFICATION_ADDED;
	}

}
