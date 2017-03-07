package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class FailedGoalObjectPropertyAssertionAxiomEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public FailedGoalObjectPropertyAssertionAxiomEvent(OWLObjectPropertyAssertionAxiom payload) {
		super(payload);
	}

}
