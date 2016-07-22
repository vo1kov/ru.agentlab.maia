package ru.agentlab.maia.agent.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLIndividual;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLClassAssertionAxiomHasIndividual extends TypeSafeEventMatcher<OWLClassAssertionAxiom> {

	IEventMatcher<? super OWLIndividual> matcher;

	public OWLClassAssertionAxiomHasIndividual(IEventMatcher<? super OWLIndividual> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLClassAssertionAxiom axiom, Map<String, Object> values) {
		OWLIndividual subject = axiom.getIndividual();
		return subject.isNamed() && matcher.matches(subject.asOWLNamedIndividual(), values);
	}

}
