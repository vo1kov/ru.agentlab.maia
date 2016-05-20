package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLClass;

public class OWLClassMatcher implements IMatcher<OWLClass> {

	private final OWLClass value;

	public OWLClassMatcher(OWLClass value) {
		this.value = value;
	}

	@Override
	public boolean match(OWLClass object, IUnifier unifier) {
		return object.equals(value);
	}

}
