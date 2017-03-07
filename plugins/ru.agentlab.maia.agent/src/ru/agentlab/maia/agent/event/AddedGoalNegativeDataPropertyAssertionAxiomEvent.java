package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLNegativeDataPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class AddedGoalNegativeDataPropertyAssertionAxiomEvent extends Event<OWLNegativeDataPropertyAssertionAxiom> {

	public AddedGoalNegativeDataPropertyAssertionAxiomEvent(OWLNegativeDataPropertyAssertionAxiom payload) {
		super(payload);
	}

}
