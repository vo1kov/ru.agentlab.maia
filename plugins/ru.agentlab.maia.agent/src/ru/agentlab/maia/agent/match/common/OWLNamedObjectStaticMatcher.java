package ru.agentlab.maia.agent.match.common;

import org.semanticweb.owlapi.model.OWLNamedObject;

import ru.agentlab.maia.agent.match.IMatch;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.Match;

public class OWLNamedObjectStaticMatcher implements IMatcher<OWLNamedObject> {

	private final String value;

	public OWLNamedObjectStaticMatcher(String value) {
		this.value = value;
	}

	@Override
	public IMatch match(OWLNamedObject object) {
		if (object.getIRI().toString().equals(value)) {
			return new Match();
		} else {
			return null;
		}
	}

}
