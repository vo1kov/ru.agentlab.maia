package ru.agentlab.maia.agent.impl;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;

import ru.agentlab.maia.agent.AgentState;

final class ActionStart extends Action {

	private static final long serialVersionUID = 1L;

	ActionStart(Agent agent) {
		super(agent);
	}

	@Override
	protected void compute() {
		agent.setState(AgentState.ACTIVE);
		OWLClassAssertionAxiom axiom = agent.createAgentStartedBelief(null);
		agent.beliefBase.add(axiom);
		agent.executor.submit(new ActionExecute(agent));
	}
}