package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.Event;

public abstract class AbstractBeliefBaseEvent extends Event<OWLAxiom> {

	public AbstractBeliefBaseEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
