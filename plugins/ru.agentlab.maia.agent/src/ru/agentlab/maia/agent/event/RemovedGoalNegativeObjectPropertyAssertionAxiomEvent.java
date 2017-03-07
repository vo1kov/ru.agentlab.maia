package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLNegativeObjectPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class RemovedGoalNegativeObjectPropertyAssertionAxiomEvent
		extends Event<OWLNegativeObjectPropertyAssertionAxiom> {

	public RemovedGoalNegativeObjectPropertyAssertionAxiomEvent(OWLNegativeObjectPropertyAssertionAxiom payload) {
		super(payload);
	}

}
