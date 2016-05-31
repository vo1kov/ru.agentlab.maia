package ru.agentlab.maia.agent.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLLiteralIsDouble extends TypeSafeMatcher<OWLLiteral> {

	Matcher<? super Double> matcher;

	public OWLLiteralIsDouble(Matcher<? super Double> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("is double ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal) {
		return literal.isDouble() && matcher.matches(literal.parseDouble());
	}

}
