package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.agent.Event;

public class AddedBeliefClassAssertionAxiomEvent extends Event<OWLClassAssertionAxiom> {

	public AddedBeliefClassAssertionAxiomEvent(OWLClassAssertionAxiom payload) {
		super(payload);
	}

}
