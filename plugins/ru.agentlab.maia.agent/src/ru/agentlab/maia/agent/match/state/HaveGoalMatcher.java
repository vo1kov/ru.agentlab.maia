package ru.agentlab.maia.agent.match.state;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.agent.IStateMatcher;

public class HaveGoalMatcher implements IStateMatcher {

	String subject;

	String predicate;

	String object;

	public HaveGoalMatcher(String subject, String predicate, String object) {
		this.subject = subject;
		this.predicate = predicate;
		this.object = object;
	}

	@Override
	public boolean match(IAgent agent) {
		return false;
	}

}
