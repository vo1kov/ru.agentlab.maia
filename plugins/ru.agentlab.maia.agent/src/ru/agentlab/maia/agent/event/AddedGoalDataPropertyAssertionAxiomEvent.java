package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class AddedGoalDataPropertyAssertionAxiomEvent extends Event<OWLDataPropertyAssertionAxiom> {

	public AddedGoalDataPropertyAssertionAxiomEvent(OWLDataPropertyAssertionAxiom payload) {
		super(payload);
	}

}
