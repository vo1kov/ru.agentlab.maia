package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLLiteralIsBoolean extends TypeSafeEventMatcher<OWLLiteral> {

	IEventMatcher<? super Boolean> matcher;

	public OWLLiteralIsBoolean(IEventMatcher<? super Boolean> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal, Map<String, Object> values) {
		return literal.isBoolean() && matcher.matches(literal.parseBoolean(), values);
	}

}
