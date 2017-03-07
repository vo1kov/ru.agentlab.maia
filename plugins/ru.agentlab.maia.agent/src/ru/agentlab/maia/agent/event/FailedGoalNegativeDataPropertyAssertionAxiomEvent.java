package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLNegativeDataPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class FailedGoalNegativeDataPropertyAssertionAxiomEvent extends Event<OWLNegativeDataPropertyAssertionAxiom> {

	public FailedGoalNegativeDataPropertyAssertionAxiomEvent(OWLNegativeDataPropertyAssertionAxiom payload) {
		super(payload);
	}

}
