package ru.agentlab.maia.agent.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedIndividual;

public class OWLIndividualIsNamed extends TypeSafeMatcher<OWLIndividual> {

	Matcher<? super OWLNamedIndividual> matcher;

	public OWLIndividualIsNamed(Matcher<? super OWLNamedIndividual> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("isNamed ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLIndividual individual) {
		return individual.isNamed() && matcher.matches(individual.asOWLNamedIndividual());
	}

}
