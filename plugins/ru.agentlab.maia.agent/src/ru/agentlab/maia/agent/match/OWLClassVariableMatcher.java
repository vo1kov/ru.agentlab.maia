package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLClass;

public class OWLClassVariableMatcher implements IMatcher<OWLClass> {

	private final String value;

	public OWLClassVariableMatcher(String value) {
		this.value = value;
	}

	@Override
	public boolean match(OWLClass object, IUnifier unifier) {
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
