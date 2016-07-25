package ru.agentlab.maia.agent.belief.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.Event;

public class BeliefRemovedEvent extends Event<OWLAxiom> {

	public BeliefRemovedEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
