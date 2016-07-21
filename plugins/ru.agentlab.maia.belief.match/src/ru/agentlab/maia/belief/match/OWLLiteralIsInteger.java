package ru.agentlab.maia.belief.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLLiteralIsInteger extends TypeSafeMatcher<OWLLiteral> {

	Matcher<? super Integer> matcher;

	public OWLLiteralIsInteger(Matcher<? super Integer> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("is integer ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal) {
		return literal.isInteger() && matcher.matches(literal.parseInteger());
	}

}
