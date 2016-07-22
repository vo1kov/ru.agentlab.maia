package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLAnonymousClassExpression;
import org.semanticweb.owlapi.model.OWLClassExpression;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLClassExpressionIsAnonymous extends TypeSafeEventMatcher<OWLClassExpression> {

	IEventMatcher<? super OWLAnonymousClassExpression> matcher;

	public OWLClassExpressionIsAnonymous(IEventMatcher<? super OWLAnonymousClassExpression> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLClassExpression expression, Map<String, Object> values) {
		return expression.isAnonymous() && matcher.matches(expression, values);
	}

}
