package ru.agentlab.maia.agent.goal.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.Event;

public class GoalAddedEvent extends Event<OWLAxiom> {

	public GoalAddedEvent(OWLAxiom goal) {
		super(goal);
	}

}
