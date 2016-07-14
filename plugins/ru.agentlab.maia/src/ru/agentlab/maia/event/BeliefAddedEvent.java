package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.EventType;

public class BeliefAddedEvent extends Event<OWLAxiom> {

	public BeliefAddedEvent(OWLAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.ADDED_BELIEF;
	}

}
