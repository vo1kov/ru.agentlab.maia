package ru.agentlab.maia.agent.belief.filter;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedIndividual;

import ru.agentlab.maia.agent.filter.IPlanEventFilter;
import ru.agentlab.maia.agent.filter.TypeSafeEventFilter;

public class OWLIndividualIsNamed extends TypeSafeEventFilter<OWLIndividual> {

	IPlanEventFilter<? super OWLNamedIndividual> matcher;

	public OWLIndividualIsNamed(IPlanEventFilter<? super OWLNamedIndividual> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLIndividual individual, Map<String, Object> values) {
		return individual.isNamed() && matcher.matches(individual.asOWLNamedIndividual(), values);
	}

}
