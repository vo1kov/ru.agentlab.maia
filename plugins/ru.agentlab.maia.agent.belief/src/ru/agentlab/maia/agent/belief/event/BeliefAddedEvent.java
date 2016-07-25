package ru.agentlab.maia.agent.belief.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.Event;

public class BeliefAddedEvent extends Event<OWLAxiom> {

	public BeliefAddedEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
