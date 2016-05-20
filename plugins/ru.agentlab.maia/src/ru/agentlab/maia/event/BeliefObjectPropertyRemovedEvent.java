package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;

public class BeliefObjectPropertyRemovedEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public BeliefObjectPropertyRemovedEvent(OWLObjectPropertyAssertionAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.BELIEF_OBJECT_PROPERTY_REMOVED;
	}

}
