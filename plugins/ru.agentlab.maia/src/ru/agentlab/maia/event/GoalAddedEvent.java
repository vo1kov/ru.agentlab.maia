package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.EventType;

public class GoalAddedEvent extends Event<OWLAxiom> {

	public GoalAddedEvent(OWLAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.ADDED_GOAL;
	}

}
