package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.agent.Event;

public class FailedGoalClassAssertionAxiomEvent extends Event<OWLClassAssertionAxiom> {

	public FailedGoalClassAssertionAxiomEvent(OWLClassAssertionAxiom payload) {
		super(payload);
	}

}
