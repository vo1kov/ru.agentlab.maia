package ru.agentlab.maia.agent.belief.match;

import java.util.Map;

import org.hamcrest.collection.IsIterableContainingInAnyOrder;
import org.semanticweb.owlapi.model.OWLDifferentIndividualsAxiom;
import org.semanticweb.owlapi.model.OWLIndividual;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLDifferentIndividualsAxiomHasIndividuals extends TypeSafeEventMatcher<OWLDifferentIndividualsAxiom> {

	IEventMatcher<Iterable<? extends OWLIndividual>> anyOrderMatcher;

	public OWLDifferentIndividualsAxiomHasIndividuals(IEventMatcher<? super OWLIndividual>[] matchers) {
		super();
//		this.anyOrderMatcher = IsIterableContainingInAnyOrder.containsInAnyOrder(matchers);
	}

	@Override
	protected boolean matchesSafely(OWLDifferentIndividualsAxiom axiom, Map<String, Object> values) {
		return anyOrderMatcher.matches(axiom.getIndividuals(), values);
	}

}
