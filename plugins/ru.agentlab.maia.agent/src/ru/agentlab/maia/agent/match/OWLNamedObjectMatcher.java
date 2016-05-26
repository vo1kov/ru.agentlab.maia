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
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof OWLNamedObjectMatcher) {
			OWLNamedObjectMatcher other = (OWLNamedObjectMatcher) obj;
			boolean result = value.equals(other.value);
			return result;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return value.hashCode();
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
