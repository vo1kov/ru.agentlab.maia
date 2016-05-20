package ru.agentlab.maia.agent.match.common;

import org.semanticweb.owlapi.model.OWLNamedObject;

import ru.agentlab.maia.agent.match.IMatch;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.Match;

public class OWLNamedObjectVariableMatcher implements IMatcher<OWLNamedObject> {

	private final String value;

	public OWLNamedObjectVariableMatcher(String value) {
		this.value = value;
	}

	@Override
	public IMatch match(OWLNamedObject object) {
		Match match = new Match();
		match.put(value, object);
		return match;
	}

}
