package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLLiteralIsFloat extends TypeSafeEventMatcher<OWLLiteral> {

	IEventMatcher<? super Float> matcher;

	public OWLLiteralIsFloat(IEventMatcher<? super Float> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal, Map<String, Object> values) {
		return literal.isFloat() && matcher.matches(literal.parseFloat(), values);
	}

}
