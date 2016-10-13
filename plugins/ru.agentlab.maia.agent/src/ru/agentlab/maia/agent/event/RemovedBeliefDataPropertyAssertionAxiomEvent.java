package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;

import ru.agentlab.maia.agent.Event;

public class RemovedBeliefDataPropertyAssertionAxiomEvent extends Event<OWLDataPropertyAssertionAxiom> {

	public RemovedBeliefDataPropertyAssertionAxiomEvent(OWLDataPropertyAssertionAxiom payload) {
		super(payload);
	}

}
