package ru.agentlab.maia.event;

import org.semanticweb.owlapi.model.OWLAxiom;

public class BeliefRemovedEvent extends Event<OWLAxiom> {

	public BeliefRemovedEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
