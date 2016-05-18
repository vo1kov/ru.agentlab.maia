package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLAxiom;

public class BeliefAddedEvent extends AbstractBeliefBaseEvent {

	public BeliefAddedEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
