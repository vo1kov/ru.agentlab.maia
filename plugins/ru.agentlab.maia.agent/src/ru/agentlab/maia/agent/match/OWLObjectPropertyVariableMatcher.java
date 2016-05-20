package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLObjectProperty;

public class OWLObjectPropertyVariableMatcher implements IMatcher<OWLObjectProperty> {

	private final String value;

	public OWLObjectPropertyVariableMatcher(String value) {
		this.value = value;
	}

	@Override
	public boolean match(OWLObjectProperty object, IUnifier unifier) {
		Object val = unifier.get(value);
		if (val != null) {
			// unifier contains value for variable, object should be the same
			return object.equals(val);
		} else {
			unifier.put(value, object);
			return true;
		}
	}

}
