package ru.agentlab.maia.agent.belief.filter;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.agent.filter.IPlanEventFilter;
import ru.agentlab.maia.agent.filter.TypeSafeEventFilter;

public class OWLLiteralIsInteger extends TypeSafeEventFilter<OWLLiteral> {

	IPlanEventFilter<? super Integer> matcher;

	public OWLLiteralIsInteger(IPlanEventFilter<? super Integer> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal, Map<String, Object> values) {
		return literal.isInteger() && matcher.matches(literal.parseInteger(), values);
	}

}
