package ru.agentlab.maia.agent.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassExpression;

public class OWLClassExpressionIsClass extends TypeSafeMatcher<OWLClassExpression> {

	Matcher<? super OWLClass> matcher;

	public OWLClassExpressionIsClass(Matcher<? super OWLClass> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("isClass ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLClassExpression expression) {
		return expression.isClassExpressionLiteral() && matcher.matches(expression.asOWLClass());
	}

}
