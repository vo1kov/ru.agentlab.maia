package ru.agentlab.maia.belief.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLNamedObject;

public class OWLNamedObjectHasIRI extends TypeSafeMatcher<OWLNamedObject> {

	Matcher<? super IRI> matcher;

	public OWLNamedObjectHasIRI(Matcher<? super IRI> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("isNamed ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(OWLNamedObject named) {
		return matcher.matches(named.getIRI());
	}

}
