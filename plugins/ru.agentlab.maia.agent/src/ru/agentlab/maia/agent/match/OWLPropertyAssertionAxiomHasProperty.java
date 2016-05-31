package ru.agentlab.maia.agent.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLPropertyExpression;

public class OWLPropertyAssertionAxiomHasProperty extends TypeSafeMatcher<OWLPropertyAssertionAxiom<?, ?>> {

	Matcher<? super OWLPropertyExpression> matcher;

	public OWLPropertyAssertionAxiomHasProperty(Matcher<? super OWLPropertyExpression> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("hasProperty ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLPropertyAssertionAxiom<?, ?> axiom) {
		return matcher.matches(axiom.getProperty());
	}

}
