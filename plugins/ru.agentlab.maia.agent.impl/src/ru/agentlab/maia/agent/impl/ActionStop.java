package ru.agentlab.maia.agent.impl;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.agent.AgentState;
import ru.agentlab.maia.agent.Event;
import ru.agentlab.maia.agent.event.AddedBeliefClassAssertionAxiomEvent;

final class ActionStop extends Action {

	private static final long serialVersionUID = 1L;

	ActionStop(Agent agent) {
		super(agent);
	}

	@Override
	protected void compute() {
		agent.setState(AgentState.STOPPING);
		OWLClassAssertionAxiom axiom = agent.createAgentStoppingBelief(null);
		Event<OWLClassAssertionAxiom> event = new AddedBeliefClassAssertionAxiomEvent(axiom);
		agent.beliefBase.add(axiom);

		handleEvent(event);

		OWLClassAssertionAxiom axiom2 = agent.createAgentStoppedBelief(null);
		agent.beliefBase.add(axiom2);

		agent.eventQueue.clear();

		agent.setState(AgentState.IDLE);
		agent.unlock();
	}
}