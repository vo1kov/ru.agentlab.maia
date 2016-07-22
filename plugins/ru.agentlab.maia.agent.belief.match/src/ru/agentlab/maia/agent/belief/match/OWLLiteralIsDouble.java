package ru.agentlab.maia.agent.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLLiteralIsDouble extends TypeSafeEventMatcher<OWLLiteral> {

	IEventMatcher<? super Double> matcher;

	public OWLLiteralIsDouble(IEventMatcher<? super Double> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal, Map<String, Object> values) {
		return literal.isDouble() && matcher.matches(literal.parseDouble(), values);
	}

}
