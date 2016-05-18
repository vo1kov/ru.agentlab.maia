package ru.agentlab.maia.agent.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.EventType;

public class BeliefRemovedEvent extends AbstractBeliefBaseEvent {

	public BeliefRemovedEvent(EventType type, OWLAxiom axiom) {
		super(axiom);
	}

}
