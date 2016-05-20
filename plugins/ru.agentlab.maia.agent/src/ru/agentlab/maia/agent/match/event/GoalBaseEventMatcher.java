package ru.agentlab.maia.agent.match.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.match.IMatch;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.common.OWLAxiomMatcher;
import ru.agentlab.maia.event.AbstractGoalBaseEvent;

public class GoalBaseEventMatcher implements IMatcher<OWLAxiom> {

	Class<? extends AbstractGoalBaseEvent> eventType;

	OWLAxiomMatcher template;

	public GoalBaseEventMatcher(Class<? extends AbstractGoalBaseEvent> eventType, OWLAxiomMatcher template) {
		this.eventType = eventType;
		this.template = template;
	}

	@Override
	public IMatch match(OWLAxiom owlAxiom) {
		return template.match(owlAxiom);
	}

}
