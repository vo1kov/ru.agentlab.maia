package ru.agentlab.maia.agent.match;

import java.util.Map;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLNamedObject;

public class OWLNamedObjectMatcher implements IMatcher<OWLNamedObject> {

	private final IRI value;

	public OWLNamedObjectMatcher(IRI value) {
		this.value = value;
	}

	@Override
	public boolean match(OWLNamedObject object, Map<String, Object> map) {
		return object.getIRI().equals(value);
	}

	@Override
	public String toString() {
		return value.toQuotedString();
	}

	@Override
	public Class<?> getType() {
		return IRI.class;
	}

	public IRI getValue() {
		return value;
	}

}
