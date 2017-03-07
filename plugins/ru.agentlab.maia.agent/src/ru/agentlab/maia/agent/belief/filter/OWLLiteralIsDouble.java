package ru.agentlab.maia.agent.belief.filter;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.agent.filter.IPlanEventFilter;
import ru.agentlab.maia.agent.filter.TypeSafeEventFilter;

public class OWLLiteralIsDouble extends TypeSafeEventFilter<OWLLiteral> {

	IPlanEventFilter<? super Double> matcher;

	public OWLLiteralIsDouble(IPlanEventFilter<? super Double> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal, Map<String, Object> values) {
		return literal.isDouble() && matcher.matches(literal.parseDouble(), values);
	}

}
