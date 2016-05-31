package ru.agentlab.maia.agent.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLDataPropertyExpression;
import org.semanticweb.owlapi.model.OWLPropertyExpression;

public class OWLPropertyExpressionIsDataPropertyExpression extends TypeSafeMatcher<OWLPropertyExpression> {

	Matcher<? super OWLDataProperty> matcher;

	public OWLPropertyExpressionIsDataPropertyExpression(Matcher<? super OWLDataProperty> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("hasObject ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLPropertyExpression property) {
		return property.isDataPropertyExpression()
				&& matcher.matches(((OWLDataPropertyExpression) property).asOWLDataProperty());
	}

}
