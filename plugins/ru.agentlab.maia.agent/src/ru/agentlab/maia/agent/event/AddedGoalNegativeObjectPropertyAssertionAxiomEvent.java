package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLNegativeObjectPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class AddedGoalNegativeObjectPropertyAssertionAxiomEvent
		extends Event<OWLNegativeObjectPropertyAssertionAxiom> {

	public AddedGoalNegativeObjectPropertyAssertionAxiomEvent(OWLNegativeObjectPropertyAssertionAxiom payload) {
		super(payload);
	}

}
