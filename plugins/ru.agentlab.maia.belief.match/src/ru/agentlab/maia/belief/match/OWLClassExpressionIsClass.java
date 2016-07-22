package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassExpression;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLClassExpressionIsClass extends TypeSafeEventMatcher<OWLClassExpression> {

	IEventMatcher<? super OWLClass> matcher;

	public OWLClassExpressionIsClass(IEventMatcher<? super OWLClass> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLClassExpression expression, Map<String, Object> values) {
		return expression.isClassExpressionLiteral() && matcher.matches(expression.asOWLClass(), values);
	}

}
