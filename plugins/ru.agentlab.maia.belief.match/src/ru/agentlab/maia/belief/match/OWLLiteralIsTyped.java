package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLLiteralIsTyped extends TypeSafeEventMatcher<OWLLiteral> {

	IEventMatcher<? super String> valueMatcher;

	IEventMatcher<? super OWLDatatype> datatypeMatcher;

	public OWLLiteralIsTyped(IEventMatcher<? super String> valueMatcher,
			IEventMatcher<? super OWLDatatype> datatypeMatcher) {
		super();
		this.valueMatcher = valueMatcher;
		this.datatypeMatcher = datatypeMatcher;
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal, Map<String, Object> values) {
		return literal.isRDFPlainLiteral() && valueMatcher.matches(literal.getLiteral(), values)
				&& datatypeMatcher.matches(literal.getDatatype(), values);
	}

}
