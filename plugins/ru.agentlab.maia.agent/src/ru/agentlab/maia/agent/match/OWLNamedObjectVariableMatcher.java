package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLNamedObject;

public class OWLNamedObjectVariableMatcher implements IMatcher<OWLNamedObject> {

	private final String value;

	public OWLNamedObjectVariableMatcher(String value) {
		this.value = value;
	}

	@Override
	public boolean match(OWLNamedObject object, IUnifier unifier) {
		Object val = unifier.get(value);
		if (val != null) {
			// unifier contains value for variable, object should be the same
			return object.equals(val);
		} else {
			unifier.put(value, object);
			return true;
		}
	}

	@Override
	public String toString() {
		return "?" + value;
	}

	@Override
	public Class<?> getType() {
		return OWLNamedObject.class;
	}

}
