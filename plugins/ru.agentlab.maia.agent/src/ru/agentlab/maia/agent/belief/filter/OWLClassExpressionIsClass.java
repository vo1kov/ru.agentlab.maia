package ru.agentlab.maia.agent.belief.filter;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassExpression;

import ru.agentlab.maia.agent.filter.IPlanEventFilter;
import ru.agentlab.maia.agent.filter.TypeSafeEventFilter;

public class OWLClassExpressionIsClass extends TypeSafeEventFilter<OWLClassExpression> {

	IPlanEventFilter<? super OWLClass> matcher;

	public OWLClassExpressionIsClass(IPlanEventFilter<? super OWLClass> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLClassExpression expression, Map<String, Object> values) {
		return expression.isClassExpressionLiteral() && matcher.matches(expression.asOWLClass(), values);
	}

}
