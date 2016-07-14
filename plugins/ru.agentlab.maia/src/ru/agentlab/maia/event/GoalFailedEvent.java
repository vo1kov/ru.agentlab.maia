package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.EventType;

public class GoalFailedEvent extends Event<OWLAxiom> {

	public GoalFailedEvent(OWLAxiom axiom) {
		super(axiom);
	}

	@Override
	public EventType getType() {
		return EventType.FAILED_GOAL;
	}

}
