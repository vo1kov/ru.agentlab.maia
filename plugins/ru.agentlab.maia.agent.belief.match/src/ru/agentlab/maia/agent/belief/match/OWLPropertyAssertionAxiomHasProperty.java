package ru.agentlab.maia.agent.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLPropertyExpression;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLPropertyAssertionAxiomHasProperty extends TypeSafeEventMatcher<OWLPropertyAssertionAxiom<?, ?>> {

	IEventMatcher<? super OWLPropertyExpression> matcher;

	public OWLPropertyAssertionAxiomHasProperty(IEventMatcher<? super OWLPropertyExpression> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLPropertyAssertionAxiom<?, ?> axiom, Map<String, Object> values) {
		return matcher.matches(axiom.getProperty(), values);
	}

}
