package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class FailedGoalDataPropertyAssertionAxiomEvent extends Event<OWLDataPropertyAssertionAxiom> {

	public FailedGoalDataPropertyAssertionAxiomEvent(OWLDataPropertyAssertionAxiom payload) {
		super(payload);
	}

}
