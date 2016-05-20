package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLDataProperty;

public class OWLDataPropertyMatcher implements IMatcher<OWLDataProperty> {

	private final OWLDataProperty value;

	public OWLDataPropertyMatcher(OWLDataProperty value) {
		this.value = value;
	}

	@Override
	public boolean match(OWLDataProperty object, IUnifier unifier) {
		return object.equals(value);
	}

	@Override
	public String toString() {
		return value.getIRI().toQuotedString();
	}

}
