package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedIndividual;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLIndividualIsNamed extends TypeSafeEventMatcher<OWLIndividual> {

	IEventMatcher<? super OWLNamedIndividual> matcher;

	public OWLIndividualIsNamed(IEventMatcher<? super OWLNamedIndividual> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLIndividual individual, Map<String, Object> values) {
		return individual.isNamed() && matcher.matches(individual.asOWLNamedIndividual(), values);
	}

}
