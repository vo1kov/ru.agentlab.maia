package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.agent.Event;

public class RemovedBeliefClassAssertionAxiomEvent extends Event<OWLClassAssertionAxiom> {

	public RemovedBeliefClassAssertionAxiomEvent(OWLClassAssertionAxiom payload) {
		super(payload);
	}

}
