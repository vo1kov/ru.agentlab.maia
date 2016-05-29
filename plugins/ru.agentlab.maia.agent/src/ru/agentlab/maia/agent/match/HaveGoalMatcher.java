package ru.agentlab.maia.agent.match;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IMatcher;

public class HaveGoalMatcher implements IMatcher {

	OWLAxiomMatcher template;

	public HaveGoalMatcher(OWLAxiomMatcher template) {
		this.template = template;
	}

	@Override
	public boolean match(IAgent agent) {
		return false;
	}

}
