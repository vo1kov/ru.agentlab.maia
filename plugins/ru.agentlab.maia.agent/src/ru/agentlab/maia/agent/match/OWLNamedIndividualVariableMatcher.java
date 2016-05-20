package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLNamedIndividual;

public class OWLNamedIndividualVariableMatcher implements IMatcher<OWLNamedIndividual> {

	private final String value;

	public OWLNamedIndividualVariableMatcher(String value) {
		this.value = value;
	}

	@Override
	public boolean match(OWLNamedIndividual object, IUnifier unifier) {
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

}
