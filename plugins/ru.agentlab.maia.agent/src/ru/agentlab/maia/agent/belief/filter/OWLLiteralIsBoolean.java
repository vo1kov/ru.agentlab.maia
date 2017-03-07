package ru.agentlab.maia.agent.belief.filter;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.agent.filter.IPlanEventFilter;
import ru.agentlab.maia.agent.filter.TypeSafeEventFilter;

public class OWLLiteralIsBoolean extends TypeSafeEventFilter<OWLLiteral> {

	IPlanEventFilter<? super Boolean> matcher;

	public OWLLiteralIsBoolean(IPlanEventFilter<? super Boolean> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal, Map<String, Object> values) {
		return literal.isBoolean() && matcher.matches(literal.parseBoolean(), values);
	}

}
