package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;

import ru.agentlab.maia.agent.Event;

public class AddedBeliefDataPropertyAssertionAxiomEvent extends Event<OWLDataPropertyAssertionAxiom> {

	public AddedBeliefDataPropertyAssertionAxiomEvent(OWLDataPropertyAssertionAxiom payload) {
		super(payload);
	}

}
