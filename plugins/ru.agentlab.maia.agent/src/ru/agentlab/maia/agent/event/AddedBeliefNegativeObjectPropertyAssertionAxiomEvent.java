package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLNegativeObjectPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class AddedBeliefNegativeObjectPropertyAssertionAxiomEvent
		extends Event<OWLNegativeObjectPropertyAssertionAxiom> {

	public AddedBeliefNegativeObjectPropertyAssertionAxiomEvent(OWLNegativeObjectPropertyAssertionAxiom payload) {
		super(payload);
	}

}
