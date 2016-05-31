package ru.agentlab.maia.agent.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;

public class OWLClassAssertionAxiomHasClassExpression extends TypeSafeMatcher<OWLClassAssertionAxiom> {

	Matcher<? super OWLClassExpression> matcher;

	public OWLClassAssertionAxiomHasClassExpression(Matcher<? super OWLClassExpression> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("hasClassExpression ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLClassAssertionAxiom axiom) {
		return matcher.matches(axiom.getClassExpression());
	}

}
