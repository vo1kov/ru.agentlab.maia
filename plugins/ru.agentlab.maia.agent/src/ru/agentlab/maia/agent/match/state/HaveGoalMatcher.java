package ru.agentlab.maia.agent.match.state;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.agent.match.IStateMatcher;
import ru.agentlab.maia.agent.match.common.OWLAxiomMatcher;

public class HaveGoalMatcher implements IStateMatcher {

	OWLAxiomMatcher template;

	public HaveGoalMatcher(OWLAxiomMatcher template) {
		this.template = template;
	}

	@Override
	public boolean match(IAgent agent) {
		return false;
	}

}
