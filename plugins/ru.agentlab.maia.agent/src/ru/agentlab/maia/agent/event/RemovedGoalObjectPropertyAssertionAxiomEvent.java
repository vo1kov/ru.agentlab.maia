package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class RemovedGoalObjectPropertyAssertionAxiomEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public RemovedGoalObjectPropertyAssertionAxiomEvent(OWLObjectPropertyAssertionAxiom payload) {
		super(payload);
	}

}
