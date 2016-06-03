package ru.agentlab.maia.hamcrest.owlapi;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLPropertyAssertionObject;

public class OWLPropertyAssertionObjectIsLiteral extends TypeSafeMatcher<OWLPropertyAssertionObject> {

	Matcher<? super OWLLiteral> matcher;

	public OWLPropertyAssertionObjectIsLiteral(Matcher<? super OWLLiteral> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("hasObject ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLPropertyAssertionObject object) {
		return (object instanceof OWLLiteral) && matcher.matches((OWLLiteral) object);
	}

}
