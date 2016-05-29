package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.IMatcher;

public class OWLLiteralBooleanMatcher extends OWLLiteralMatcher {

	private final IMatcher<? super Boolean> booleanMatcher;

	public OWLLiteralBooleanMatcher(IMatcher<? super Boolean> booleanMatcher) {
		this.booleanMatcher = booleanMatcher;
	}

	@Override
	public boolean match(OWLLiteral literal, Map<String, Object> map) {
		return literal.isBoolean() && booleanMatcher.match(literal.parseBoolean(), map);
	}

	@Override
	public String toString() {
		return "OWLLiteralBooleanMatcher (" + booleanMatcher.toString() + ")";
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof OWLLiteralBooleanMatcher) {
			OWLLiteralBooleanMatcher other = (OWLLiteralBooleanMatcher) obj;
			return booleanMatcher.equals(other.booleanMatcher);
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(booleanMatcher);
	}

}
