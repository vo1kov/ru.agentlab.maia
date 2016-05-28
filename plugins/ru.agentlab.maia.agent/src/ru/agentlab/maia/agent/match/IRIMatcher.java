package ru.agentlab.maia.agent.match;

import java.util.Map;

import org.semanticweb.owlapi.model.IRI;

public class IRIMatcher implements IMatcher<IRI> {

	private final IRI value;

	public IRIMatcher(IRI value) {
		this.value = value;
	}

	@Override
	public boolean match(IRI object, Map<String, Object> map) {
		return object.equals(value);
	}

	@Override
	public String toString() {
		return value.toQuotedString();
	}

	@Override
	public Class<IRI> getType() {
		return IRI.class;
	}

	public IRI getValue() {
		return value;
	}

}
