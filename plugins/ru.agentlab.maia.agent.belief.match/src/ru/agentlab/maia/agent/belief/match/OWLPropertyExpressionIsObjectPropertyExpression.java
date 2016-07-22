package ru.agentlab.maia.agent.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLObjectPropertyExpression;
import org.semanticweb.owlapi.model.OWLPropertyExpression;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLPropertyExpressionIsObjectPropertyExpression extends TypeSafeEventMatcher<OWLPropertyExpression> {

	IEventMatcher<? super OWLObjectProperty> matcher;

	public OWLPropertyExpressionIsObjectPropertyExpression(IEventMatcher<? super OWLObjectProperty> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLPropertyExpression property, Map<String, Object> values) {
		return property.isObjectPropertyExpression()
				&& matcher.matches(((OWLObjectPropertyExpression) property).asOWLObjectProperty(), values);
	}

}
