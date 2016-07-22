package ru.agentlab.maia.agent.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLDataPropertyExpression;
import org.semanticweb.owlapi.model.OWLPropertyExpression;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLPropertyExpressionIsDataPropertyExpression extends TypeSafeEventMatcher<OWLPropertyExpression> {

	IEventMatcher<? super OWLDataProperty> matcher;

	public OWLPropertyExpressionIsDataPropertyExpression(IEventMatcher<? super OWLDataProperty> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLPropertyExpression property, Map<String, Object> values) {
		return property.isDataPropertyExpression()
				&& matcher.matches(((OWLDataPropertyExpression) property).asOWLDataProperty(), values);
	}

}
