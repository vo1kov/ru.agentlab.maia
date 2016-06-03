package ru.agentlab.maia.hamcrest.owlapi;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLLiteralIsFloat extends TypeSafeMatcher<OWLLiteral> {

	Matcher<? super Float> matcher;

	public OWLLiteralIsFloat(Matcher<? super Float> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("is float ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal) {
		return literal.isFloat() && matcher.matches(literal.parseFloat());
	}

}
