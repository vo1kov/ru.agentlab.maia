package ru.agentlab.maia.agent.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLClassExpression;

import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLClassExpressionIsNothing extends TypeSafeEventMatcher<OWLClassExpression> {

	@Override
	protected boolean matchesSafely(OWLClassExpression expression, Map<String, Object> values) {
		return expression.isOWLNothing();
	}

}
