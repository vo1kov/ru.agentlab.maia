package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLNegativeObjectPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class RemovedBeliefNegativeObjectPropertyAssertionAxiomEvent
		extends Event<OWLNegativeObjectPropertyAssertionAxiom> {

	public RemovedBeliefNegativeObjectPropertyAssertionAxiomEvent(OWLNegativeObjectPropertyAssertionAxiom payload) {
		super(payload);
	}

}
