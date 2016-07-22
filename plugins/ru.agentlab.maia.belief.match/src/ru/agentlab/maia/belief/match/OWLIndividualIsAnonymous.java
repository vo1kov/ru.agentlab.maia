package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLAnonymousIndividual;
import org.semanticweb.owlapi.model.OWLIndividual;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLIndividualIsAnonymous extends TypeSafeEventMatcher<OWLIndividual> {

	IEventMatcher<? super OWLAnonymousIndividual> matcher;

	public OWLIndividualIsAnonymous(IEventMatcher<? super OWLAnonymousIndividual> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLIndividual individual, Map<String, Object> values) {
		return individual.isAnonymous() && matcher.matches(individual.asOWLAnonymousIndividual(), values);
	}

}
