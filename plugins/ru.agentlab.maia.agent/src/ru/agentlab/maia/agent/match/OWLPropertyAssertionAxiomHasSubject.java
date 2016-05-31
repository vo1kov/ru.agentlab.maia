package ru.agentlab.maia.agent.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLPropertyAssertionAxiom;

public class OWLPropertyAssertionAxiomHasSubject extends TypeSafeMatcher<OWLPropertyAssertionAxiom<?, ?>> {

	Matcher<? super OWLIndividual> matcher;

	public OWLPropertyAssertionAxiomHasSubject(Matcher<? super OWLIndividual> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("hasSubject ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLPropertyAssertionAxiom<?, ?> axiom) {
		return matcher.matches(axiom.getSubject());
	}

}
