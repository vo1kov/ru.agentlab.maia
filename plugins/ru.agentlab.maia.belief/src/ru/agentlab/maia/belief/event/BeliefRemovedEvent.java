package ru.agentlab.maia.belief.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.Event;

public class BeliefRemovedEvent extends Event<OWLAxiom> {

	public BeliefRemovedEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
