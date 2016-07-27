package ru.agentlab.maia.goal.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.Event;

public class GoalAddedEvent extends Event<OWLAxiom> {

	public GoalAddedEvent(OWLAxiom goal) {
		super(goal);
	}

}
