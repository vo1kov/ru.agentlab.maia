package ru.agentlab.maia.hamcrest.owlapi;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLAnonymousClassExpression;
import org.semanticweb.owlapi.model.OWLClassExpression;

public class OWLClassExpressionIsAnonymous extends TypeSafeMatcher<OWLClassExpression> {

	Matcher<? super OWLAnonymousClassExpression> matcher;

	public OWLClassExpressionIsAnonymous(Matcher<? super OWLAnonymousClassExpression> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("isClass ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLClassExpression expression) {
		return expression.isAnonymous() && matcher.matches(expression);
	}

}
