package ru.agentlab.maia.goal.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.Event;

public class GoalFailedEvent extends Event<OWLAxiom> {

	public GoalFailedEvent(OWLAxiom axiom) {
		super(axiom);
	}

}
