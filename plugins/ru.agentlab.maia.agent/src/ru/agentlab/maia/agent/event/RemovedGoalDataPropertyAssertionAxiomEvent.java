package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;

import ru.agentlab.maia.agent.Event;

public class RemovedGoalDataPropertyAssertionAxiomEvent extends Event<OWLDataPropertyAssertionAxiom> {

	public RemovedGoalDataPropertyAssertionAxiomEvent(OWLDataPropertyAssertionAxiom payload) {
		super(payload);
	}

}
