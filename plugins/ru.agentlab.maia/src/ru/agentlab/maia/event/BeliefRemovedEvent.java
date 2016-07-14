package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.EventType;

public class BeliefRemovedEvent extends Event<OWLAxiom> {

	public BeliefRemovedEvent(OWLAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.REMOVED_BELIEF;
	}

}
