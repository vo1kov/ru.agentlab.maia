package ru.agentlab.maia.belief.match;

import org.hamcrest.Description;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLClassExpression;

public class OWLClassExpressionIsThing extends TypeSafeMatcher<OWLClassExpression> {

	@Override
	public void describeTo(Description description) {
		description.appendText("is OWLThing");
	}

	@Override
	protected boolean matchesSafely(OWLClassExpression expression) {
		return expression.isOWLThing();
	}

}
