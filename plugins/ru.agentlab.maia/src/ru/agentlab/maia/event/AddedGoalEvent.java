package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.EventType;

public class AddedGoalEvent extends Event<OWLAxiom> {

	public AddedGoalEvent(OWLAxiom goal) {
		super(goal);
	}

	@Override
	public EventType getType() {
		return EventType.ADDED_GOAL;
	}

}
