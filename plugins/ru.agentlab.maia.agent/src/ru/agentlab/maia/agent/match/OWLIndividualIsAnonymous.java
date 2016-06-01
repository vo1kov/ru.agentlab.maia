package ru.agentlab.maia.agent.match;

import static org.hamcrest.CoreMatchers.anything;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLAnonymousIndividual;
import org.semanticweb.owlapi.model.OWLIndividual;

public class OWLIndividualIsAnonymous extends TypeSafeMatcher<OWLIndividual> {

	Matcher<? super OWLAnonymousIndividual> matcher;

	public OWLIndividualIsAnonymous(Matcher<? super OWLAnonymousIndividual> matcher) {
		super();
		this.matcher = matcher;
	}

	public OWLIndividualIsAnonymous() {
		super();
		this.matcher = anything();
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("isAnonymous ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLIndividual individual) {
		return individual.isAnonymous() && matcher.matches(individual.asOWLAnonymousIndividual());
	}

}
