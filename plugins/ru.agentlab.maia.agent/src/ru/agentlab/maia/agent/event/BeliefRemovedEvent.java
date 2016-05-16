package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.EventType;

public class BeliefRemovedEvent extends BeliefBaseEvent {

	public BeliefRemovedEvent(EventType type, OWLAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.BELIEF_REMOVED;
	}

}
