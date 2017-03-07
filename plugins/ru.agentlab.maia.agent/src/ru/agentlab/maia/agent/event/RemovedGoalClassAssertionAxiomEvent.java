package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.Event;

public class RemovedGoalClassAssertionAxiomEvent extends Event<OWLClassAssertionAxiom> {

	public RemovedGoalClassAssertionAxiomEvent(OWLClassAssertionAxiom payload) {
		super(payload);
	}

}
