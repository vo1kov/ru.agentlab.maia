package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLLiteralIsInteger extends TypeSafeEventMatcher<OWLLiteral> {

	IEventMatcher<? super Integer> matcher;

	public OWLLiteralIsInteger(IEventMatcher<? super Integer> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal, Map<String, Object> values) {
		return literal.isInteger() && matcher.matches(literal.parseInteger(), values);
	}

}
