package ru.agentlab.maia.belief.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLLiteralIsBoolean extends TypeSafeMatcher<OWLLiteral> {

	Matcher<? super Boolean> matcher;

	public OWLLiteralIsBoolean(Matcher<? super Boolean> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("is boolean ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal) {
		return literal.isBoolean() && matcher.matches(literal.parseBoolean());
	}

}
