package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLClassAssertionAxiomHasClassExpression extends TypeSafeEventMatcher<OWLClassAssertionAxiom> {

	IEventMatcher<? super OWLClassExpression> matcher;

	public OWLClassAssertionAxiomHasClassExpression(IEventMatcher<? super OWLClassExpression> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLClassAssertionAxiom axiom, Map<String, Object> values) {
		return matcher.matches(axiom.getClassExpression(), values);
	}

}
