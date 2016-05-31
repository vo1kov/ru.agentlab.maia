package ru.agentlab.maia.agent.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLPropertyAssertionObject;

public class OWLPropertyAssertionObjectIsIndividual extends TypeSafeMatcher<OWLPropertyAssertionObject> {

	Matcher<? super OWLIndividual> matcher;

	public OWLPropertyAssertionObjectIsIndividual(Matcher<? super OWLIndividual> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("hasObject ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLPropertyAssertionObject object) {
		return (object instanceof OWLIndividual) && matcher.matches((OWLIndividual) object);
	}

}
