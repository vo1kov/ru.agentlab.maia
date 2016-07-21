package ru.agentlab.maia.belief.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLLiteralIsTyped extends TypeSafeMatcher<OWLLiteral> {

	Matcher<? super String> valueMatcher;

	Matcher<? super OWLDatatype> datatypeMatcher;

	public OWLLiteralIsTyped(Matcher<? super String> valueMatcher, Matcher<? super OWLDatatype> datatypeMatcher) {
		super();
		this.valueMatcher = valueMatcher;
		this.datatypeMatcher = datatypeMatcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("is integer ").appendDescriptionOf(valueMatcher);
	}

	@Override
	protected boolean matchesSafely(OWLLiteral literal) {
		return literal.isRDFPlainLiteral() && valueMatcher.matches(literal.getLiteral())
				&& datatypeMatcher.matches(literal.getDatatype());
	}

}
