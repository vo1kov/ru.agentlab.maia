package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLNegativeDataPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class RemovedGoalNegativeDataPropertyAssertionAxiomEvent extends Event<OWLNegativeDataPropertyAssertionAxiom> {

	public RemovedGoalNegativeDataPropertyAssertionAxiomEvent(OWLNegativeDataPropertyAssertionAxiom payload) {
		super(payload);
	}

}
