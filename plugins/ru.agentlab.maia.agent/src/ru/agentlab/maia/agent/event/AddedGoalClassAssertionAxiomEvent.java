package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.Event;

public class AddedGoalClassAssertionAxiomEvent extends Event<OWLClassAssertionAxiom> {

	public AddedGoalClassAssertionAxiomEvent(OWLClassAssertionAxiom payload) {
		super(payload);
	}

}
