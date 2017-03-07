package ru.agentlab.maia.agent.belief.filter;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;

import ru.agentlab.maia.agent.filter.IPlanEventFilter;
import ru.agentlab.maia.agent.filter.TypeSafeEventFilter;

public class OWLClassAssertionAxiomHasClassExpression extends TypeSafeEventFilter<OWLClassAssertionAxiom> {

	IPlanEventFilter<? super OWLClassExpression> matcher;

	public OWLClassAssertionAxiomHasClassExpression(IPlanEventFilter<? super OWLClassExpression> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLClassAssertionAxiom axiom, Map<String, Object> values) {
		return matcher.matches(axiom.getClassExpression(), values);
	}

}
