package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLNegativeDataPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class RemovedBeliefNegativeDataPropertyAssertionAxiomEvent extends Event<OWLNegativeDataPropertyAssertionAxiom> {

	public RemovedBeliefNegativeDataPropertyAssertionAxiomEvent(OWLNegativeDataPropertyAssertionAxiom payload) {
		super(payload);
	}

}
