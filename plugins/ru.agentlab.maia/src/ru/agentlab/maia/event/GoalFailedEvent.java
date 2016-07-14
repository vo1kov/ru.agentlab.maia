package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLAxiom;

public class GoalFailedEvent extends Event<OWLAxiom> {

	public GoalFailedEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
