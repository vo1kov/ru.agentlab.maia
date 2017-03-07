package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class RemovedBeliefObjectPropertyAssertionAxiomEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public RemovedBeliefObjectPropertyAssertionAxiomEvent(OWLObjectPropertyAssertionAxiom payload) {
		super(payload);
	}

}
