package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLNegativeObjectPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class FailedGoalNegativeObjectPropertyAssertionAxiomEvent
		extends Event<OWLNegativeObjectPropertyAssertionAxiom> {

	public FailedGoalNegativeObjectPropertyAssertionAxiomEvent(OWLNegativeObjectPropertyAssertionAxiom payload) {
		super(payload);
	}

}
