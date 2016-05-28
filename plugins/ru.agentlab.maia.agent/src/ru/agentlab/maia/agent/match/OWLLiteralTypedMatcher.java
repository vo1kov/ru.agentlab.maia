package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLLiteralTypedMatcher extends OWLLiteralMatcher {

	IMatcher<? super String> literalMatcher;

	IMatcher<? super OWLDatatype> datatypeMatcher;

	public OWLLiteralTypedMatcher(IMatcher<? super String> literalMatcher,
			IMatcher<? super OWLDatatype> datatypeMatcher) {
		this.literalMatcher = literalMatcher;
		this.datatypeMatcher = datatypeMatcher;
	}

	@Override
	public boolean match(OWLLiteral literal, Map<String, Object> map) {
		return literalMatcher.match(literal.getLiteral(), map) && datatypeMatcher.match(literal.getDatatype(), map);
	}

	@Override
	public String toString() {
		return "OWLLiteralTypedMatcher (" + literalMatcher.toString() + "^^" + datatypeMatcher.toString() + ")";
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof OWLLiteralTypedMatcher) {
			OWLLiteralTypedMatcher other = (OWLLiteralTypedMatcher) obj;
			return literalMatcher.equals(other.literalMatcher) && datatypeMatcher.equals(other.datatypeMatcher);
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return Objects.hash(literalMatcher, datatypeMatcher);
	}

}
