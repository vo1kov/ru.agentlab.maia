package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLNegativeDataPropertyAssertionAxiom;

import ru.agentlab.maia.agent.Event;

public class AddedBeliefNegativeDataPropertyAssertionAxiomEvent extends Event<OWLNegativeDataPropertyAssertionAxiom> {

	public AddedBeliefNegativeDataPropertyAssertionAxiomEvent(OWLNegativeDataPropertyAssertionAxiom payload) {
		super(payload);
	}

}
