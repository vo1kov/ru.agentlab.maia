package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLLiteralIsPlain extends TypeSafeEventMatcher<OWLLiteral> {

	IEventMatcher<? super String> valueMatcher;

	IEventMatcher<? super String> languageMatcher;

	public OWLLiteralIsPlain(IEventMatcher<? super String> valueMatcher,
			IEventMatcher<? super String> languageMatcher) {
		super();
		this.valueMatcher = valueMatcher;
		this.languageMatcher = languageMatcher;
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal, Map<String, Object> values) {
		return literal.isRDFPlainLiteral() && valueMatcher.matches(literal.getLiteral(), values)
				&& languageMatcher.matches(literal.getLang(), values);
	}

}
