package ru.agentlab.maia.hamcrest.owlapi;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLObjectPropertyExpression;
import org.semanticweb.owlapi.model.OWLPropertyExpression;

public class OWLPropertyExpressionIsObjectPropertyExpression extends TypeSafeMatcher<OWLPropertyExpression> {

	Matcher<? super OWLObjectProperty> matcher;

	public OWLPropertyExpressionIsObjectPropertyExpression(Matcher<? super OWLObjectProperty> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("is Object Property ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLPropertyExpression property) {
		return property.isObjectPropertyExpression()
				&& matcher.matches(((OWLObjectPropertyExpression) property).asOWLObjectProperty());
	}

}
