package ru.agentlab.maia.agent.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLPropertyAssertionObject;

public class OWLPropertyAssertionAxiomHasObject extends TypeSafeMatcher<OWLDataPropertyAssertionAxiom> {

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
	protected boolean matchesSafely(OWLDataPropertyAssertionAxiom axiom) {
		return matcher.matches(axiom.getObject());
	}

}
