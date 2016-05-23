package ru.agentlab.maia.agent.match;

import java.util.Objects;

import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLLiteralMatcher implements IMatcher<OWLLiteral> {

	private final OWLLiteral object;

	public OWLLiteralMatcher(OWLLiteral object) {
		this.object = object;
	}

	@Override
	public boolean match(OWLLiteral object, IUnifier unifier) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Class<?> getType() {
		return OWLLiteral.class;
	}

	@Override
	public String toString() {
		return "OWLLiteralMatcher " + object.toString();
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj instanceof OWLLiteralMatcher) {
			return object.equals(((OWLLiteralMatcher) obj).object);
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(object);
	}

}
