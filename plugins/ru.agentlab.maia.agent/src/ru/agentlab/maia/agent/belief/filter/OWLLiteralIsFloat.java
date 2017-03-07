package ru.agentlab.maia.agent.belief.filter;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.agent.filter.IPlanEventFilter;
import ru.agentlab.maia.agent.filter.TypeSafeEventFilter;

public class OWLLiteralIsFloat extends TypeSafeEventFilter<OWLLiteral> {

	IPlanEventFilter<? super Float> matcher;

	public OWLLiteralIsFloat(IPlanEventFilter<? super Float> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal, Map<String, Object> values) {
		return literal.isFloat() && matcher.matches(literal.parseFloat(), values);
	}

}
