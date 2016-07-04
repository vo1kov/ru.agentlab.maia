package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.EventType;

public class AddedBeliefEvent extends Event<OWLAxiom> {

	public AddedBeliefEvent(OWLAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.ADDED_BELIEF;
	}

}
