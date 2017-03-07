package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.Event;

public class AddedBeliefObjectPropertyAssertionAxiomEvent extends Event<OWLObjectPropertyAssertionAxiom> {

	public AddedBeliefObjectPropertyAssertionAxiomEvent(OWLObjectPropertyAssertionAxiom payload) {
		super(payload);
	}

}
