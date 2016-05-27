package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLLiteralDoubleMatcher extends OWLLiteralMatcher {

	private final IMatcher<? super Double> doubleMatcher;

	public OWLLiteralDoubleMatcher(IMatcher<? super Double> booleanMatcher) {
		this.doubleMatcher = booleanMatcher;
	}

	@Override
	public boolean match(OWLLiteral literal, Map<String, Object> map) {
		return literal.isDouble() && doubleMatcher.match(literal.parseDouble(), map);
	}

	@Override
	public String toString() {
		return "OWLLiteralDoubleMatcher (" + doubleMatcher.toString() + ")";
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof OWLLiteralDoubleMatcher) {
			OWLLiteralDoubleMatcher other = (OWLLiteralDoubleMatcher) obj;
			return doubleMatcher.equals(other.doubleMatcher);
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(doubleMatcher);
	}

}
