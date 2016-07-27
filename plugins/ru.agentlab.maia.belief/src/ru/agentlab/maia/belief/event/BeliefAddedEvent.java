package ru.agentlab.maia.belief.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.Event;

public class BeliefAddedEvent extends Event<OWLAxiom> {

	public BeliefAddedEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
