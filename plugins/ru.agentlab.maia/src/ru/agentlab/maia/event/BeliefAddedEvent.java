package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLAxiom;

public class BeliefAddedEvent extends Event<OWLAxiom> {

	public BeliefAddedEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
