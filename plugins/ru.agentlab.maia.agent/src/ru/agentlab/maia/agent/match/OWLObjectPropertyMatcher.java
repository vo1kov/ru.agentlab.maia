package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLObjectProperty;

public class OWLObjectPropertyMatcher implements IMatcher<OWLObjectProperty> {

	private final OWLObjectProperty value;

	public OWLObjectPropertyMatcher(OWLObjectProperty value) {
		this.value = value;
	}

	@Override
	public boolean match(OWLObjectProperty object, IUnifier unifier) {
		return object.equals(value);
	}

}
