package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class BeliefDataPropertyRemovedEvent extends Event<OWLDataPropertyAssertionAxiom> {

	public BeliefDataPropertyRemovedEvent(OWLDataPropertyAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.BELIEF_DATA_PROPERTY_REMOVED;
	}

}
