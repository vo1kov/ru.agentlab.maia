package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLNamedIndividual;

public class OWLNamedIndividualMatcher implements IMatcher<OWLNamedIndividual> {

	private final OWLNamedIndividual value;

	public OWLNamedIndividualMatcher(OWLNamedIndividual value) {
		this.value = value;
	}

	@Override
	public boolean match(OWLNamedIndividual object, IUnifier unifier) {
		return object.equals(value);
	}

	@Override
	public String toString() {
		return value.getIRI().toQuotedString();
	}

}
