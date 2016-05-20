package ru.agentlab.maia.agent.match.event;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.match.IMatch;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.event.AbstractBeliefBaseEvent;

public class BeliefBaseEventMatcher implements IMatcher<OWLAxiom> {

	Class<? extends AbstractBeliefBaseEvent> eventType;

	OWLAxiomMatcher template;

	public BeliefBaseEventMatcher(Class<? extends AbstractBeliefBaseEvent> eventType, OWLAxiomMatcher template) {
		this.eventType = eventType;
		this.template = template;
	}

	@Override
	public IMatch match(OWLAxiom owlAxiom) {
		return template.match(owlAxiom);
	}

}
