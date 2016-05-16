package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.EventType;

public class BeliefAddedEvent extends BeliefBaseEvent {

	public BeliefAddedEvent(OWLAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.BELIEF_ADDED;
	}

}
