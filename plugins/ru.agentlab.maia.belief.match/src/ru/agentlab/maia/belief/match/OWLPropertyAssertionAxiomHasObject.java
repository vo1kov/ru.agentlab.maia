package ru.agentlab.maia.belief.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLPropertyAssertionObject;

public class OWLPropertyAssertionAxiomHasObject extends TypeSafeMatcher<OWLPropertyAssertionAxiom<?, ?>> {

	Matcher<? super OWLPropertyAssertionObject> matcher;

	public OWLPropertyAssertionAxiomHasObject(Matcher<? super OWLPropertyAssertionObject> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("hasObject ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLPropertyAssertionAxiom<?, ?> axiom) {
		return matcher.matches(axiom.getObject());
	}

}
