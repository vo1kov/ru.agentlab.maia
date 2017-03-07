package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class AddedGoalObjectPropertyAssertionAxiomEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public AddedGoalObjectPropertyAssertionAxiomEvent(OWLObjectPropertyAssertionAxiom payload) {
		super(payload);
	}

}
