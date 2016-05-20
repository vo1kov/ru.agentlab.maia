package ru.agentlab.maia.agent.match.state;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.agent.match.IMatch;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.IStateMatcher;
import ru.agentlab.maia.agent.match.common.OWLNamedObjectMatcher;

public class HaveBeliefClassificationMatcher implements IMatcher<IBeliefBase> {

	OWLNamedObjectMatcher subject;

	OWLNamedObjectMatcher predicate;

	OWLNamedObjectMatcher object;

	public HaveBeliefClassificationMatcher(OWLNamedObjectMatcher subject, OWLNamedObjectMatcher predicate, OWLNamedObjectMatcher object) {
		this.subject = subject;
		this.predicate = predicate;
		this.object = object;
	}

	@Override
	public IMatch match(IBeliefBase object) {
		// TODO Auto-generated method stub
		return null;
	}

}
