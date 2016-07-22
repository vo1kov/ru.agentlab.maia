package ru.agentlab.maia.agent.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLPropertyAssertionAxiom;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLPropertyAssertionAxiomHasSubject extends TypeSafeEventMatcher<OWLPropertyAssertionAxiom<?, ?>> {

	IEventMatcher<? super OWLIndividual> matcher;

	public OWLPropertyAssertionAxiomHasSubject(IEventMatcher<? super OWLIndividual> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLPropertyAssertionAxiom<?, ?> axiom, Map<String, Object> values) {
		return matcher.matches(axiom.getSubject(), values);
	}

}
