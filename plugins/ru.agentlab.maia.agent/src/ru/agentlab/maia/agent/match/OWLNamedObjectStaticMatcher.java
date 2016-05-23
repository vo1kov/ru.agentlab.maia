package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLNamedObject;

public class OWLNamedObjectStaticMatcher implements IMatcher<OWLNamedObject> {

	private final OWLNamedObject value;

	public OWLNamedObjectStaticMatcher(OWLNamedObject value) {
		this.value = value;
	}

	@Override
	public boolean match(OWLNamedObject object, IUnifier unifier) {
		return object.equals(value);
	}

	@Override
	public String toString() {
		return value.getIRI().toQuotedString();
	}

	@Override
	public Class<?> getType() {
		return OWLNamedObject.class;
	}

}
