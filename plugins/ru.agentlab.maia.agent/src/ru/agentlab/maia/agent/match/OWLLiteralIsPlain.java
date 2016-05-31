package ru.agentlab.maia.agent.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLLiteralIsPlain extends TypeSafeMatcher<OWLLiteral> {

	Matcher<? super String> valueMatcher;

	Matcher<? super String> languageMatcher;

	public OWLLiteralIsPlain(Matcher<? super String> valueMatcher, Matcher<? super String> languageMatcher) {
		super();
		this.valueMatcher = valueMatcher;
		this.languageMatcher = languageMatcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("is integer ").appendDescriptionOf(valueMatcher);
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal) {
		return literal.isRDFPlainLiteral() && valueMatcher.matches(literal.getLiteral())
				&& languageMatcher.matches(literal.getLang());
	}

}
