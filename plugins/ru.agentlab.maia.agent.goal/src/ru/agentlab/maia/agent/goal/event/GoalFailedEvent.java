package ru.agentlab.maia.agent.goal.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.Event;

public class GoalFailedEvent extends Event<OWLAxiom> {

	public GoalFailedEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
