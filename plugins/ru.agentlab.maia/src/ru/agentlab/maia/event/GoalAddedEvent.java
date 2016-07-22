package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLAxiom;

public class GoalAddedEvent extends Event<OWLAxiom> {

	public GoalAddedEvent(OWLAxiom goal) {
		super(goal);
	}

}
