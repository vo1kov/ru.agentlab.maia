package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.hamcrest.collection.IsIterableContainingInAnyOrder;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLDisjointClassesAxiom;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLDisjointClassesAxiomHasClasses extends TypeSafeEventMatcher<OWLDisjointClassesAxiom> {

	IEventMatcher<Iterable<? extends OWLClassExpression>> anyOrderMatcher;

	public OWLDisjointClassesAxiomHasClasses(IEventMatcher<? super OWLClassExpression>[] matchers) {
		super();
		this.anyOrderMatcher = IsIterableContainingInAnyOrder.containsInAnyOrder(matchers);
	}

	@Override
	protected boolean matchesSafely(OWLDisjointClassesAxiom axiom, Map<String, Object> values) {
		return anyOrderMatcher.matches(axiom.getClassExpressions(), values);
	}

}
