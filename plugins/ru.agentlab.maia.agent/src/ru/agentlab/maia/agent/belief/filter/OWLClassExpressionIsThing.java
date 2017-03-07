package ru.agentlab.maia.agent.belief.filter;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLClassExpression;

import ru.agentlab.maia.agent.filter.TypeSafeEventFilter;

public class OWLClassExpressionIsThing extends TypeSafeEventFilter<OWLClassExpression> {

	@Override
	protected boolean matchesSafely(OWLClassExpression expression, Map<String, Object> values) {
		return expression.isOWLThing();
	}

}
