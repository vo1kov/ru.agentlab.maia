package ru.agentlab.maia.hamcrest.owlapi;

import org.hamcrest.Description;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLClassExpression;

public class OWLClassExpressionIsNothing extends TypeSafeMatcher<OWLClassExpression> {

	@Override
	public void describeTo(Description description) {
		description.appendText("is OWLNothing");
	}

	@Override
	protected boolean matchesSafely(OWLClassExpression expression) {
		return expression.isOWLNothing();
	}

}
