package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.Event;

public abstract class BeliefBaseEvent extends Event<OWLAxiom> {

	public BeliefBaseEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
