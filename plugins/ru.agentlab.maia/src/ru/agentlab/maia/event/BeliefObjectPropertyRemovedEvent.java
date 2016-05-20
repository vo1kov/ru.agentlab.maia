package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.EventType;

public class BeliefObjectPropertyRemovedEvent extends Event<OWLClassAssertionAxiom> {

	public BeliefObjectPropertyRemovedEvent(OWLClassAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.BELIEF_OBJECT_PROPERTY_REMOVED;
	}

}
