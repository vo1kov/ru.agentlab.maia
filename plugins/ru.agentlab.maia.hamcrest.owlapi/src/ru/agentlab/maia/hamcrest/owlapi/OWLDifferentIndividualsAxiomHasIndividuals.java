package ru.agentlab.maia.hamcrest.owlapi;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.hamcrest.collection.IsIterableContainingInAnyOrder;
import org.semanticweb.owlapi.model.OWLDifferentIndividualsAxiom;
import org.semanticweb.owlapi.model.OWLIndividual;

public class OWLDifferentIndividualsAxiomHasIndividuals extends TypeSafeMatcher<OWLDifferentIndividualsAxiom> {

	Matcher<Iterable<? extends OWLIndividual>> anyOrderMatcher;

	public OWLDifferentIndividualsAxiomHasIndividuals(Matcher<? super OWLIndividual>[] matchers) {
		super();
		this.anyOrderMatcher = IsIterableContainingInAnyOrder.containsInAnyOrder(matchers);
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("hasDisjointClasses ");// .appendDescriptionOf(matchers);
	}

	@Override
	protected boolean matchesSafely(OWLDifferentIndividualsAxiom axiom) {
		return anyOrderMatcher.matches(axiom.getIndividuals());
	}

}
