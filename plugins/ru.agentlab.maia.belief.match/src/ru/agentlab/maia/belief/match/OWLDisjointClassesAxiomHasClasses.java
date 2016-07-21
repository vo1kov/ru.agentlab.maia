package ru.agentlab.maia.belief.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.hamcrest.collection.IsIterableContainingInAnyOrder;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLDisjointClassesAxiom;

public class OWLDisjointClassesAxiomHasClasses extends TypeSafeMatcher<OWLDisjointClassesAxiom> {

	Matcher<Iterable<? extends OWLClassExpression>> anyOrderMatcher;

	public OWLDisjointClassesAxiomHasClasses(Matcher<? super OWLClassExpression>[] matchers) {
		super();
		this.anyOrderMatcher = IsIterableContainingInAnyOrder.containsInAnyOrder(matchers);
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("hasDisjointClasses ");// .appendDescriptionOf(matchers);
	}

	@Override
	protected boolean matchesSafely(OWLDisjointClassesAxiom axiom) {
		return anyOrderMatcher.matches(axiom.getClassExpressions());
	}

}
