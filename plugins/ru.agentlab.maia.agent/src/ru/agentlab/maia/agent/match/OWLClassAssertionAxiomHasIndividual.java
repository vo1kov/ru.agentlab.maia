package ru.agentlab.maia.agent.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLIndividual;

public class OWLClassAssertionAxiomHasIndividual extends TypeSafeMatcher<OWLClassAssertionAxiom> {

	Matcher<? super OWLIndividual> matcher;

	public OWLClassAssertionAxiomHasIndividual(Matcher<? super OWLIndividual> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("hasIndividual ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLClassAssertionAxiom axiom) {
		OWLIndividual subject = axiom.getIndividual();
		return subject.isNamed() && matcher.matches(subject.asOWLNamedIndividual());
	}

}
